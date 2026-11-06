# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
from pathlib import Path
import tempfile,unittest
from cleanlang.core import Environment,Expr,Expressions,CleanError,lean
from cleanlang.modules import load_module,load_document
from cleanlang.conversion import local_definition,comparison_normal_form
ROOT=Path(__file__).resolve().parents[1]
class LocalConversion(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.e=Environment();load_module(ROOT/'library/topology/relative_maps.clean',cls.e)
        load_module(ROOT/'library/topology/interlevel.clean',cls.e)
    def setUp(self):
        self.locals={}
        for n,t in [('K','Type'),('field','FieldStructure(K)'),('H','HomologyTheory(K,field)'),
                    ('X','TopologicalSpace'),('P','TopologicalPair(X)'),('Q','TopologicalPair(X)'),('a','Real')]:
            self.locals[n]=Expr(n,n,self.e.type(t,self.locals))
    def expr(self,s):return Expressions(self.e,self.locals).parse(s)
    def bind(self,n,s):self.locals[n]=local_definition(n,self.expr(s),self.e,self.locals)
    def typ(self,s):return self.e.type(s,self.locals)
    def test_local_indices_convert_and_keep_names(self):
        self.bind('R','relative chains(field,H,X,P)');self.bind('S','R')
        a=self.typ('ChainMap(K,field,R,S)')
        b=self.typ('ChainMap(K,field,(relative chains(field,H,X,P)),(relative chains(field,H,X,P)))')
        self.assertEqual(a,b);self.assertEqual(hash(a),hash(b))
        self.assertNotEqual(self.e.render_type(a,'lean'),self.e.render_type(b,'lean'))
        self.assertIn(' R ',self.e.render_type(a,'lean'))
    def test_distinct_variables_and_native_terms_stay_distinct(self):
        self.bind('R','relative chains(field,H,X,P)')
        self.assertNotEqual(self.typ('ChainMap(K,field,R,R)'),
          self.typ('ChainMap(K,field,(relative chains(field,H,X,Q)),(relative chains(field,H,X,Q)))'))
    def test_record_alias_projection_and_comparison_only(self):
        self.bind('I','endpoints(a,a)')
        original=self.expr('I.lower')
        self.assertEqual(comparison_normal_form(original,self.e,self.locals).lean,'a')
        self.assertIn('I',original.lean)
    def test_binder_definitions_remain_opaque(self):
        self.bind('f','function(x: Real,x)')
        self.assertIsNone(self.locals['f'].local_normal)
        self.assertIn('f',comparison_normal_form(self.expr('f(a)'),self.e,self.locals).lean)
    def test_actual_statement_keeps_let_and_dependent_type(self):
        source=f'''Import "{ROOT}/library/topology/relative_maps.clean"
Source test:
  Kind: other
  Label: Local conversion
  Title: Local definition checks
Result local names:
  Attribution: test; local indices; original
  Let K: Type
  Let field: FieldStructure(K)
  Let H: HomologyTheory(K,field)
  Let X: TopologicalSpace
  Let P: TopologicalPair(X)
  Let R = relative chains(field,H,X,P)
  Let f: ChainMap(K,field,R,R)
  Conclude: f = f
'''
        with tempfile.TemporaryDirectory() as d:
            p=Path(d)/'test.clean';p.write_text(source)
            e=Environment();rs=load_document(p,e)
        target=lean(rs,e,[])
        self.assertIn('let R :',target);self.assertIn(' R R',target)
    def test_function_alias_call_head_converts(self):
        self.locals['g']=Expr('g','g',self.typ('Function(Real,Real)'))
        self.bind('f','g')
        norm=lambda s:comparison_normal_form(self.expr(s),self.e,self.locals).lean
        self.assertEqual(norm('f(a)'),norm('g(a)'))
        self.assertIn('f',self.expr('f(a)').lean)
    def test_alias_does_not_change_automatic_label(self):
        from cleanlang.conditions import source_expression
        self.bind('Y','X')
        self.assertEqual(source_expression(self.expr('Y').tree),'Y')
    def test_alias_declaration_is_not_available_to_its_value(self):
        with self.assertRaisesRegex(CleanError,'Unknown name'):
            self.bind('R','R')
    def test_assumed_equality_does_not_identify_objects(self):
        self.locals['h']=Expr('h','h',self.typ('Evidence((P = Q))'))
        self.bind('R','P')
        self.assertNotEqual(self.typ('Evidence((R = P))'),self.typ('Evidence((R = Q))'))

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
    def test_legacy_bare_dimensions_remain_outside_this_rule(self):
        self.locals['n']=Expr('n','n',self.typ('Natural'))
        self.bind('m','n')
        self.assertNotEqual(self.typ('Vector(n,Real)'),self.typ('Vector(m,Real)'))
