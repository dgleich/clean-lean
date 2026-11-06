# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from cleanlang.core import Environment,Expr,Type,Expressions,CleanError
from cleanlang.modules import load_module,notation
from cleanlang.dependent_functions import DependentFunctionType
ROOT=Path(__file__).resolve().parents[1]

class ConstantPi(unittest.TestCase):
    def setUp(self):
        self.e=Environment();load_module(ROOT/'library/topology/basic.clean',self.e)
        notation('Define fixed(n,m):',['Let n,m: Natural','Returns: Natural','Equals: n'],self.e,authored=True)
        self.local={'n':Expr('n','n',Type('Natural'))}
    def typ(self,s):return self.e.type(s,self.local)
    def test_conversion_preserves_declared_binder(self):
        a=self.typ('Function(p: Natural,Vertex((fixed(n,p))))')
        b=self.typ('Function(Natural,Vertex(n))')
        self.assertIsInstance(a,DependentFunctionType)
        self.assertEqual(a,b);self.assertEqual(b,a);self.assertEqual(hash(a),hash(b))
        self.assertEqual({a:'value'}[b],'value')
        self.assertIn('clean_pi_bound',self.e.render_type(a,'lean'))
        self.assertIn('cleanDefine_fixed',self.e.render_type(a,'lean'))
    def test_nested_dependency_survives(self):
        a=self.typ('Function(p: Natural,Function(q: Natural,Vertex((fixed(p,q)))))')
        b=self.typ('Function(p: Natural,Function(Natural,Vertex(p)))')
        self.assertEqual(a,b);self.assertEqual(hash(a),hash(b))
        self.assertNotEqual(a,self.typ('Function(Natural,Function(Natural,Vertex(n)))'))
    def test_genuine_dependency_is_not_constant(self):
        self.assertNotEqual(self.typ('Function(p: Natural,Vertex(p))'),self.typ('Function(Natural,Vertex(n))'))
    def test_call_matching_both_directions(self):
        for name,spelling,actual in [
            ('accept dependent','Function(p: Natural,Vertex((fixed(n,p))))','Function(Natural,Vertex(n))'),
            ('accept ordinary','Function(Natural,Vertex(n))','Function(p: Natural,Vertex((fixed(n,p))))')]:
            notation('Notation '+name+'(n,f):',['Let n: Natural','Let f: '+spelling,
                     'Returns: Natural','Means: n','Render latex: {n}'],self.e)
            self.local['f']=Expr('f','f',self.typ(actual))
            self.assertEqual(Expressions(self.e,self.local).parse(name+'(n,f)').type,Type('Natural'))
    def test_call_rejects_genuine_dependency(self):
        notation('Notation accept(n,f):',['Let n: Natural','Let f: Function(Natural,Vertex(n))',
                 'Returns: Natural','Means: n','Render latex: {n}'],self.e)
        self.local['f']=Expr('f','f',self.typ('Function(p: Natural,Vertex(p))'))
        with self.assertRaises(CleanError):Expressions(self.e,self.local).parse('accept(n,f)')

class DiagramDefinitions(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.e=Environment();load_module(ROOT/'library/diagrams/interval_bases.clean',cls.e)
    def test_actual_records(self):
        self.assertEqual([n for n,t in self.e.structures['IntervalBasis']['fields']],
                         ['vectors','basis','realizes','vanishes','compatible'])
        for name in ['constant module diagram','zigzag shape','constant zigzag','interval labels at']:
            self.assertEqual(self.e.definitions[name]['implementation'],'equals')
    def test_wrong_diagram_arrow_rejected(self):
        local={}
        for n,t in [('K','Type'),('field','FieldStructure(K)'),('V','Type'),('E','Type'),
                    ('Q','DiagramShape(V,E)'),('M','CoefficientModule(K,field)'),('N','CoefficientModule(K,field)')]:
            local[n]=Expr(n,n,self.e.type(t,local))
        with self.assertRaises(CleanError):Expressions(self.e,local).parse(
            'module diagram(K,field,V,E,Q,function(v: V,M),function(e: E,module identity(field,N)))')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md

    def test_independent_call_tree(self):
        from cleanlang.syntax import parse,expression_tree
        self.assertEqual(expression_tree(parse('constant diagram(field,Q,M)','expression')),
          ['Call','constant diagram',[['Local','field'],['Local','Q'],['Local','M']]])
    def test_opaque_shape_projection(self):
        from cleanlang.conversion import comparison_normal_form,index_comparison
        from cleanlang.syntax import parse,expression_tree
        local={}
        for name,typ in [('n','Natural'),('d','Function(Vertex(n),Boolean)')]:
            local[name]=Expr(name,name,self.e.type(typ,local),tree=['Local',name])
        source='zigzag shape(n,d).target'
        value=Expressions(self.e,local).parse(source)
        self.assertEqual(value.tree,['Projection',['Call','zigzag shape',
            [['Local','n'],['Local','d']]],'target'])
        self.assertEqual(comparison_normal_form(value,self.e,local).lean,value.lean)
        self.assertEqual(index_comparison(value,self.e,local),value.lean)
