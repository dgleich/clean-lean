# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from cleanlang import syntax
from cleanlang.core import Environment,Expr,Type,CleanError,Expressions
from cleanlang.modules import load_module,notation,type_declaration
from cleanlang.structures import declare
from cleanlang.indices import ComputedIndex
ROOT=Path(__file__).resolve().parents[1]
class ComputedIndices(unittest.TestCase):
    def setUp(self):
        self.e=Environment();load_module(ROOT/'library/topology/homology.clean',self.e)
        self.local={}
        for n,t in [('K','Type'),('field','FieldStructure(K)'),('H','HomologyTheory(K,field)'),
                    ('X','TopologicalSpace'),('Y','TopologicalSpace'),('f','ContinuousMap(X,Y)'),
                    ('x','HomologyClass(K,field,H,X)')]:
            self.local[n]=Expr(n,n,self.e.type(t,self.local))
    def expr(self,s):return Expressions(self.e,self.local).parse(s)
    def test_independent_tree(self):
        self.assertEqual(syntax.type_tree(syntax.parse('ModuleElement(K,field,(homology module(field,H,X)))','type_ref')),
            ['Apply','ModuleElement',[['Name','K'],['Name','field'],['ComputedIndex',
             ['Call','homology module',[['Local','field'],['Local','H'],['Local','X']]]]]])
    def test_typed_let_balanced_parentheses(self):
        text='ModuleElement(K,field,(homology module(field,H,X)))'
        self.assertEqual(syntax.let_clause('Let x: '+text),('let',['x'],text))
    def test_compact_header_preserves_type(self):
        header='Notation use(x: ModuleElement(K,field,(homology module(field,H,X)))): Real:'
        self.assertEqual(syntax.header(header)[2][0][1],
                         'ModuleElement(K,field,(homology module(field,H,X)))')
    def test_alias_is_structural(self):
        self.assertEqual(self.local['x'].type,
                         self.e.type('ModuleElement(K,field,(homology module(field,H,X)))',self.local))
        self.assertIsInstance(self.local['x'].type.args[-1],ComputedIndex)
    def test_grouping_normalizes(self):
        self.assertEqual(self.e.type('HomologyTheory(K,(field))',self.local),self.local['H'].type)
        self.assertEqual(self.e.type('ModuleElement(K,field,((homology module(field,H,X))))',self.local),
                         self.local['x'].type)
    def test_expression_requires_delimiters(self):
        with self.assertRaises(CleanError):
            self.e.type('ModuleElement(K,field,homology module(field,H,X))',self.local)
    def test_wrong_slot_and_wrong_type(self):
        for text in ['Set((homology module(field,H,X)))','ModuleElement(K,field,(X))']:
            with self.subTest(text=text),self.assertRaises(CleanError):self.e.type(text,self.local)
    def test_no_binders_in_indices(self):
        with self.assertRaisesRegex(CleanError,'do not introduce binders'):
            self.e.type('ModuleElement(K,field,(function(z: Real,z)))',self.local)
    def test_no_alias_unfolding(self):
        value=self.expr('homology module(field,H,X)')
        self.local['M']=Expr('M','M',value.type)
        self.assertNotEqual(self.e.type('ModuleElement(K,field,M)',self.local),self.local['x'].type)
    def test_generic_map_consumes_computed_modules(self):
        actual=self.expr('module map value(field,homology module(field,H,X),homology module(field,H,Y),homology linear map(field,H,X,Y,f),x)')
        self.assertEqual(actual.type,self.e.type('HomologyClass(K,field,H,Y)',self.local))
    def test_wrong_computed_ambient_rejected(self):
        with self.assertRaisesRegex(CleanError,'index mismatch'):
            self.expr('module map value(field,homology module(field,H,Y),homology module(field,H,X),homology linear map(field,H,X,Y,f),x)')
    def test_computed_dependent_record_field(self):
        declare('Structure HomologyPoint(K: Type, field: FieldStructure(K), H: HomologyTheory(K,field)):',
          ['Let space: TopologicalSpace','Let point: HomologyClass(K,field,H,space)',
           'Constructor: homology point'],self.e)
        self.local['P']=Expr('P','P',self.e.type('HomologyPoint(K,field,H)',self.local))
        self.assertEqual(self.expr('P.point').type,
          self.e.type('ModuleElement(K,field,(homology module(field,H,P.space)))',self.local))
    def test_quantified_computation_uses_fresh_lean_binder(self):
        value=self.expr('for every (Z: TopologicalSpace, for every (z: HomologyClass(K,field,H,Z), z=z))')
        self.assertIn('(clean_bound_0)',value.lean)
        self.assertNotIn('(Z)',value.lean)
    def test_arithmetic_substitution(self):
        type_declaration('Type At(x: Real):',['Means: Real','Render latex: A({x})'],self.e)
        notation('Notation preserve(x,y):',['Let x: Real','Let y: At((x+x))',
          'Returns: At((x+x))','Means: y','Render latex: {y}'],self.e)
        self.local['a']=Expr('a','a',Type('Real'))
        self.local['v']=Expr('v','v',self.e.type('At((a+a))',self.local))
        self.assertEqual(self.expr('preserve(a,v)').type,self.local['v'].type)
    def test_function_parameter_substitution(self):
        type_declaration('Type At(x: Real):',['Means: Real','Render latex: A({x})'],self.e)
        notation('Notation keep(f,x,y):',['Let f: Function(Real,Real)','Let x: Real',
          'Let y: At((f(x)))','Returns: At((f(x)))','Means: y','Render latex: {y}'],self.e)
        self.local['a']=Expr('a','a',Type('Real'))
        self.local['q']=Expr('q','q',self.e.type('Function(Real,Real)',self.local))
        self.local['v']=Expr('v','v',self.e.type('At((q(a)))',self.local))
        self.assertEqual(self.expr('keep(q,a,v)').type,self.local['v'].type)
    def test_natural_dimension_computation(self):
        notation('Notation next size(n):',['Let n: Natural','Returns: Natural',
                 'Means: n+1','Render latex: {n}+1'],self.e)
        self.local['n']=Expr('n','n',Type('Natural'))
        self.assertEqual(self.e.type('Vector((n),Real)',self.local),self.e.type('Vector(n,Real)',self.local))
        t=self.e.type('Vector((next size(n)),Real)',self.local)
        self.assertIsInstance(t.args[0],ComputedIndex)
        self.assertIn('cleanNotation_next_size',self.e.render_type(t,'lean'))
        with self.assertRaisesRegex(CleanError,'must be Natural'):
            self.e.type('Vector((1),Real)',self.local)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md

    def test_nonfunction_local_does_not_capture_module_callable(self):
        type_declaration('Type At(x: Real):',['Means: Real','Render latex: A({x})'],self.e)
        notation('Notation scalar(x):',['Let x: Real','Returns: Real','Means: x','Render latex: {x}'],self.e)
        notation('Notation keep scalar(scalar,y):',['Let scalar: Real','Let y: At((scalar(scalar)))',
          'Returns: At((scalar(scalar)))','Means: y','Render latex: {y}'],self.e)
        self.local['a']=Expr('a','a',Type('Real'))
        self.local['v']=Expr('v','v',self.e.type('At((scalar(a)))',self.local))
        self.assertEqual(self.expr('keep scalar(a,v)').type,self.local['v'].type)
