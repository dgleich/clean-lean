# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from cleanlang.core import Environment,Expr,Expressions,Type,NAT,CleanError
from cleanlang.modules import load_module,notation
from cleanlang.dependent_functions import DependentFunctionType
ROOT=Path(__file__).resolve().parents[1]

class DependentFunctions(unittest.TestCase):
    def setUp(self):
        self.e=Environment();load_module(ROOT/'library/types.clean',self.e)
    def typ(self,s,local=None):return self.e.type(s,local or {})
    def expr(self,s,local=None):return Expressions(self.e,local or {}).parse(s)
    def test_alpha_equality_and_hash(self):
        a=self.typ('Function(n: Natural,Vector(n,Real))')
        b=self.typ('Function(k: Natural,Vector(k,Real))')
        self.assertEqual(a,b);self.assertEqual(hash(a),hash(b))
        self.assertEqual(self.e.render_type(a,'lean'),'(clean_pi_bound_0 : ℕ) → (Fin clean_pi_bound_0 → ℝ)')
    def test_nested_alpha(self):
        a=self.typ('Function(n: Natural,Function(m: Natural,Matrix(n,m,Real)))')
        b=self.typ('Function(i: Natural,Function(j: Natural,Matrix(i,j,Real)))')
        c=self.typ('Function(i: Natural,Function(j: Natural,Matrix(j,i,Real)))')
        self.assertEqual(a,b);self.assertEqual(hash(a),hash(b));self.assertNotEqual(a,c)
    def test_free_outer_dimension_is_not_bound(self):
        local={'n':Expr('n','n',NAT)}
        self.assertNotEqual(self.typ('Function(k: Natural,Vector(k,Real))'),
                            self.typ('Function(k: Natural,Vector(n,Real))',local))
    def test_constant_arrow_collapses(self):
        self.assertEqual(self.typ('Function(x: Real,Real)'),self.typ('Function(Real,Real)'))
    def test_application_and_dimension_kind(self):
        local={'f':Expr('f','f',self.typ('Function(n: Natural,Vector(n,Real))')),
               'm':Expr('m','m',NAT)}
        from cleanlang.indices import DimensionIndex
        for s in ['f(m)','f(0)','f(1)']:
            t=self.expr(s,local).type
            self.assertIsInstance(t.args[0],DimensionIndex)
        self.assertEqual(self.expr('f(m)',local).type,self.typ('Vector(m,Real)',local))
        self.assertEqual(self.expr('f(m)',local).lean,'(f m)')
        for s in ['f()','f(m,m)','f(f)']:
            with self.subTest(s=s),self.assertRaises(CleanError):self.expr(s,local)
    def test_nested_capture_avoidance(self):
        local={'f':Expr('f','f',self.typ('Function(n: Natural,Function(m: Natural,Matrix(n,m,Real)))')),
               'm':Expr('m','m',NAT),'k':Expr('k','k',NAT)}
        local['g']=self.expr('f(m)',local)
        self.assertEqual(self.expr('g(k)',local).type,self.typ('Matrix(m,k,Real)',local))
        self.assertNotEqual(local['g'].type.binder,'m')
    def test_inferred_lambda(self):
        t=self.expr('function(n: Natural,function(i: Vertex(n),i))').type
        self.assertIsInstance(t,DependentFunctionType)
        self.assertEqual(t,self.typ('Function(k: Natural,Function(Vertex(k),Vertex(k)))'))
    def test_fresh_compiler_identity(self):
        local={'z':Expr('clean_pi_bound_0','z',NAT)}
        t=self.typ('Function(n: Natural,Matrix(n,z,Real))',local)
        self.assertEqual(t.bound,'clean_pi_bound_1')
        self.assertIn('Fin clean_pi_bound_0',self.e.render_type(t,'lean'))
    def test_scope_and_module_gate(self):
        for s in ['Matrix(n: Natural,Real)','Function(T: Type,T)',
                  'Function(n: Natural,Function(n: Natural,Vector(n,Real)))',
                  'Function(n: Vertex(n),Real)','Function(Real: Natural,Real)']:
            with self.subTest(s=s),self.assertRaises(CleanError):self.typ(s)
        with self.assertRaises(CleanError):self.typ('Vector(n,Real)')
        self.e.data['types']['Mapping']=self.e.data['types'].pop('Function')
        self.assertIsInstance(self.typ('Mapping(n: Natural,Vector(n,Real))'),DependentFunctionType)
    def test_infer_free_type_from_dependent_codomain(self):
        notation('Notation family identity(f):',[
          'Let T: Type','Let f: Function(n: Natural,Vector(n,T))',
          'Returns: Function(n: Natural,Vector(n,T))','Means: f','Render latex: {f}'],self.e)
        t=self.typ('Function(k: Natural,Vector(k,Real))')
        local={'f':Expr('f','f',t)}
        self.assertEqual(self.expr('family identity(f)',local).type,t)
        self.assertEqual(set(local),{'f'})
    def test_rendering(self):
        t=self.typ('Function(n: Natural,Vector(n,Real))')
        self.assertIn(r'\prod_',self.e.render_type(t,'latex'))
        self.assertIn('assigning to each',self.e.describe_type(t))
    def test_infer_only_free_dimensions(self):
        notation('Notation rectangular family(f):',[
          'Let n: Natural','Let f: Function(p: Natural,Matrix(n,p,Real))',
          'Returns: Function(p: Natural,Matrix(n,p,Real))','Means: f','Render latex: {f}'],self.e)
        local={'m':Expr('m','m',NAT)}
        t=self.typ('Function(q: Natural,Matrix(m,q,Real))',local)
        local['f']=Expr('f','f',t)
        self.assertEqual(self.expr('rectangular family(f)',local).type,t)
        local['f']=Expr('f','f',self.typ('Function(q: Natural,Matrix(q,q,Real))'))
        with self.assertRaisesRegex(CleanError,'cannot escape'):self.expr('rectangular family(f)',local)
        self.assertEqual(set(local),{'m','f'})
    def test_dependent_field_application(self):
        load_module(ROOT/'library/algebra/graded_maps.clean',self.e)
        local={}
        for n,t in [('K','Type'),('field','FieldStructure(K)'),('M','GradedModule(K,field)'),
                    ('N','GradedModule(K,field)'),('f','GradedMap(K,field,M,N)'),('p','Natural')]:
            local[n]=Expr(n,n,self.typ(t,local))
        result=self.expr('f.component(p)',local)
        self.assertEqual(result.type,self.typ('ModuleMap(K,field,(M.component(p)),(N.component(p)))',local))
        self.assertEqual(self.e.definitions['graded identity']['implementation'],'equals')
        self.assertEqual(self.e.definitions['graded composition']['implementation'],'equals')
    def test_alias_and_automatic_label(self):
        from cleanlang.modules import type_declaration
        from cleanlang.conditions import source_expression,lean_name
        type_declaration('Type VectorFamily():', ['Equals: Function(n: Natural,Vector(n,Real))'],self.e)
        self.assertEqual(self.typ('VectorFamily'),self.typ('Function(k: Natural,Vector(k,Real))'))
        term=self.expr('function(f: Function(n: Natural,Vector(n,Real)),f)')
        label=source_expression(term.tree)
        self.assertIn('Function(n: Natural,Vector(n,Real))',label)
        self.assertEqual(lean_name(label),lean_name(source_expression(term.tree)))

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
    def test_comparison_name_does_not_capture_formal_dimension(self):
        notation('Notation compiler named family(f):',[
          'Let clean_comparison_binder: Natural',
          'Let f: Function(p: Natural,Matrix(clean_comparison_binder,p,Real))',
          'Returns: Function(p: Natural,Matrix(clean_comparison_binder,p,Real))',
          'Means: f','Render latex: {f}'],self.e)
        local={'n':Expr('n','n',NAT)}
        t=self.typ('Function(q: Natural,Matrix(n,q,Real))',local)
        local['f']=Expr('f','f',t)
        self.assertEqual(self.expr('compiler named family(f)',local).type,t)
    def test_alias_cycles_crossing_bound_arrows_reject(self):
        from cleanlang.modules import type_declaration
        for body in ['Function(n: Natural,RecursiveFamily)',
                     'Function(n: Natural,Function(Real,RecursiveFamily))']:
            self.e.data['types'].pop('RecursiveFamily',None)
            with self.subTest(body=body),self.assertRaisesRegex(CleanError,'Cyclic type alias'):
                type_declaration('Type RecursiveFamily():',['Equals: '+body],self.e)
