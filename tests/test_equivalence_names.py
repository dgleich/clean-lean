# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from cleanlang.core import Environment,Expr,Expressions,PROP
from cleanlang.modules import load_module
ROOT=Path(__file__).resolve().parents[1]
class EquivalenceNames(unittest.TestCase):
 def test_logical_operator_and_type_constructor_coexist(self):
  for names in [('operators','logic/equivalence_operations'),('logic/equivalence_operations','operators')]:
   e=Environment()
   for name in names:load_module(ROOT/'library'/(name+'.clean'),e)
   scope={n:Expr(n,n,PROP,tree=['Local',n]) for n in ['p','q']}
   value=Expressions(e,scope).parse('p ↔ q')
   self.assertEqual(value.operator_binding[0],'logical equivalence')
   self.assertEqual(value.lean,Expressions(e,scope).parse('logical equivalence(p,q)').lean)
   self.assertEqual(len(e.data['functions']['equivalence']['signature_tree'][2]),6)
   self.assertEqual(len(e.data['functions']['logical equivalence']['signature_tree'][2]),2)
   self.assertNotEqual(e.data['functions']['equivalence']['native_binding'],e.data['functions']['logical equivalence']['native_binding'])
