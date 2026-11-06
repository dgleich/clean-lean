# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from cleanlang.core import Environment,Expr,Type,Expressions,CleanError,lean
from cleanlang.modules import load_module,load_document
ROOT=Path(__file__).resolve().parents[1]
class HomologyInterfaces(unittest.TestCase):
    def setUp(self):
        self.env=Environment();load_module(ROOT/'library/topology/homology.clean',self.env)
        self.locals={}
        for name,t in [('K','Type'),('field','FieldStructure(K)'),('other','FieldStructure(K)'),
          ('H','HomologyTheory(K,field)'),('J','HomologyTheory(K,field)'),
          ('X','TopologicalSpace'),('Y','TopologicalSpace'),
          ('f','ContinuousMap(X,Y)'),('x','HomologyClass(K,field,H,X)')]:
            self.locals[name]=Expr(name,name,self.env.type(t,self.locals))
    def parse(self,text):return Expressions(self.env,self.locals).parse(text)
    def test_correct_ambient_space(self):
        self.assertEqual(self.parse('induced homology value(field,H,X,Y,f,x)').type,
                         self.env.type('HomologyClass(K,field,H,Y)',self.locals))
    def test_coefficient_choice_is_not_erased(self):
        for text in ['induced homology value(other,H,X,Y,f,x)',
                     'induced homology value(field,J,X,Y,f,x)',
                     'induced homology value(field,H,Y,X,f,x)']:
            with self.subTest(text=text),self.assertRaisesRegex(CleanError,'index mismatch'):
                self.parse(text)
    def test_map_is_an_authored_lambda(self):
        name=self.env.data['functions']['induced homology map']['lean'].split()[0]
        self.assertIn('fun (clean_bound_0',self.env.notation_definitions[name])
        self.assertEqual(self.parse('induced homology map(field,H,X,Y,f)').type.name,'Function')
    def test_module_result_keeps_field_index(self):
        self.assertEqual(self.parse('homology module(field,H,X)').type,
                         self.env.type('CoefficientModule(K,field)',self.locals))
    def test_theory_degree_and_coefficients(self):
        self.assertEqual(self.parse('H.degree').type,Type('Natural'))
        self.assertEqual(self.parse('H.coefficients').type,
                         self.env.type('CoefficientModule(K,field)',self.locals))
    def test_specimen_has_no_placeholder_proof(self):
        e=Environment();results=load_document(ROOT/'studies/topology/Homology.clean',e)
        source=lean(results,e,[])
        self.assertEqual(len(results),5)
        self.assertNotIn('CleanPapers',source)
        self.assertNotIn('sorry',source)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
