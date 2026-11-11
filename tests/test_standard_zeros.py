# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from cleanlang.core import Environment,Expressions,Expr,CleanError
from cleanlang.modules import load_module,notation

ROOT=Path(__file__).resolve().parents[1]
class StandardZeros(unittest.TestCase):
 def setUp(self):
  self.env=Environment();load_module(ROOT/'library/linear_algebra.clean',self.env)
  self.scope={name:Expr(name,name,self.env.type('Natural'),tree=['Local',name]) for name in ('m','n')}
 def test_annotated_shapes_and_order(self):
  for scalar in ('Real','Complex'):
   for shape,arguments in [('Vector',['n']),('Matrix',['m','n'])]:
    carrier=shape+'('+','.join(arguments+[scalar])+')'
    value=Expressions(self.env,self.scope).parse('(0: '+carrier+')')
    self.assertEqual(value.type,self.env.type(carrier,self.scope))
    self.assertEqual(value.tree[3],scalar.lower()+' '+shape.lower()+' zero')
    self.assertEqual([a[2] for a in value.tree[5]],[['Local',n] for n in arguments])
 def test_scalar_zero_remains_a_numeral(self):
  for carrier in ('Real','Complex','Natural'):
   value=Expressions(self.env,self.scope).parse('(0: '+carrier+')')
   self.assertEqual(value.tree[0],'BoundNumeral')
 def test_scalar_default_is_not_a_vector_default(self):
  value=Expressions(self.env,self.scope).parse('0')
  self.assertEqual(value.type,self.env.type('Natural'))
 def test_competing_zero_declaration_is_ambiguous(self):
  notation('Notation alternate(n: Natural): Vector(n,Complex):',
   ['Means: fun _ => (0 : Complex)','Literal: 0','Render latex: 0'],self.env)
  with self.assertRaisesRegex(CleanError,'Ambiguous literal interpretation'):
   Expressions(self.env,self.scope).parse('(0: Vector(n,Complex))')
 def test_rectangular_one_is_not_silently_an_identity(self):
  with self.assertRaises(CleanError):
   Expressions(self.env,self.scope).parse('(1: Matrix(m,n,Complex))')

if __name__=='__main__':unittest.main()

# generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md
