# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from cleanlang.core import Environment, Expr, Expressions, CleanError
from cleanlang.modules import load_module
ROOT = Path(__file__).resolve().parents[1]

class HomologySequence(unittest.TestCase):
 @classmethod
 def setUpClass(cls):
  cls.env = Environment()
  load_module(ROOT/'library/algebra/homology_sequences.clean', cls.env)
 def setUp(self):
  self.scope = {}
  for name, typ in [('K','Type'), ('field','FieldStructure(K)'),
    ('S','ChainShortSequence(K,field)'), ('T','ChainShortSequence(K,field)'),
    ('n','Natural'), ('h','Evidence((short exact chain sequence(field,S)))'),
    ('other','Evidence((short exact chain sequence(field,T)))')]:
   self.scope[name] = Expr(name,name,self.env.type(typ,self.scope),tree=['Local',name])
 def expr(self,text):
  return Expressions(self.env,self.scope).parse(text)
 def test_independent_call_tree(self):
  self.assertEqual(self.expr('connecting homology map(field,S,h,n)').tree,
   ['Call','connecting homology map', [['Local','field'],['Local','S'],['Local','h'],['Local','n']]])
 def test_degree_shift_and_direction(self):
  actual = self.expr('connecting homology map(field,S,h,n)').type
  expected = self.env.type('ModuleMap(K,field,(chain homology(field,sequence last chain(field,S),n+1)),(chain homology(field,sequence first chain(field,S),n)))',self.scope)
  reversed_type = self.env.type('ModuleMap(K,field,(chain homology(field,sequence first chain(field,S),n)),(chain homology(field,sequence last chain(field,S),n+1)))',self.scope)
  self.assertEqual(actual,expected)
  self.assertNotEqual(actual,reversed_type)
 def test_evidence_must_belong_to_the_sequence(self):
  for text in ['connecting homology map(field,S,other,n)', 'connecting homology map(field,S,n,n)']:
   with self.subTest(text=text), self.assertRaises(CleanError):self.expr(text)
 def test_exactness_pairs_have_matching_middle_modules(self):
  for text in [
    'exact(connecting homology map(field,S,h,n),sequence first homology map(field,S,n))',
    'exact(sequence first homology map(field,S,n),sequence last homology map(field,S,n))',
    'exact(sequence last homology map(field,S,n+1),connecting homology map(field,S,h,n))']:
   with self.subTest(text=text):
    self.assertEqual(self.expr(text).type,self.env.type('Proposition',self.scope))
  with self.assertRaises(CleanError):
   self.expr('exact(sequence last homology map(field,S,n),connecting homology map(field,S,h,n))')
 def test_composites_are_authored(self):
  for name in ['connecting then first','last then connecting','sequence first homology map','sequence last homology map']:
   self.assertEqual(self.env.definitions[name]['implementation'],'equals')

if __name__ == '__main__': unittest.main()

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
