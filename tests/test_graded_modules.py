# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from cleanlang.core import Environment,Expr,Expressions,CleanError,lean
from cleanlang.modules import load_document
ROOT=Path(__file__).resolve().parents[1]
class GradedModules(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.e=Environment();cls.rs=load_document(ROOT/'studies/dependent-functions/Available.clean',cls.e)
    def test_definitions_are_authored(self):
        for name in ['component module','graded singular homology']:
            self.assertEqual(self.e.definitions[name]['implementation'],'equals')
        self.assertEqual(self.e.definitions['graded singular homology']['tree'][0:2],['Call','graded module'])
        self.assertEqual(self.e.definitions['graded singular homology']['tree'][2][2][0],'Lambda')
    def test_explicit_universe_and_component(self):
        self.assertEqual(self.e.data['types']['GradedModule']['universe'],1)
        self.assertEqual([n for n,_ in self.e.structures['GradedModule']['fields']],['component'])
        self.assertEqual(len(self.rs),1)
        self.assertIn('def graded_homology_component : Prop',lean(self.rs,self.e,[]))
    def test_component_field_is_callable(self):
        local={}
        for n,t in [('K','Type'),('field','FieldStructure(K)'),('M','GradedModule(K,field)'),('p','Natural')]:
            local[n]=Expr(n,n,self.e.type(t,local))
        term=Expressions(self.e,local).parse('M.component(p)')
        self.assertEqual(term.type,self.e.type('CoefficientModule(K,field)',local))
        with self.assertRaises(CleanError):Expressions(self.e,local).parse('M.component(M)')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
    def test_lambda_bearing_producer_comparison_is_still_opaque(self):
        from cleanlang.conversion import comparison_normal_form
        local={}
        for n,t in [('K','Type'),('field','FieldStructure(K)'),('X','TopologicalSpace'),('p','Natural')]:
            local[n]=Expr(n,n,self.e.type(t,local))
        expr=lambda s:Expressions(self.e,local).parse(s)
        a=expr('graded singular homology(K,field,X).component(p)')
        b=expr('homology module(field,scalar homology(K,field,p),X)')
        self.assertEqual(a.type,b.type)
        self.assertNotEqual(comparison_normal_form(a,self.e,local).lean,
                            comparison_normal_form(b,self.e,local).lean)
