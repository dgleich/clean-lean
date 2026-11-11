# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
import unittest
from pathlib import Path
from cleanlang.core import Environment,Expr,Expressions,CleanError
from cleanlang.modules import load_module,type_declaration,notation
from cleanlang.retained_codec import dumps,loads
ROOT=Path(__file__).resolve().parents[1]

class ClassifierLiteralInteractions(unittest.TestCase):
 def setUp(self):
  self.e=Environment();load_module(ROOT/'library/operators.clean',self.e)
  type_declaration('Type OtherSmall():',['Universe: 1','Classifies: 0','Means: Type','Render latex: S'],self.e)
 def test_explicit_literal_carrier_uses_formal_classifier(self):
  notation('Notation empty(T):',['Let T: Type','Returns: List(T)','Means: []','Literal: 0','Render latex: []'],self.e)
  with self.assertRaisesRegex(CleanError,'Ambiguous carrier classifier'):
   Expressions(self.e,{}).parse('type(Real)')
  value=Expressions(self.e,{}).parse('(0: List(Real))')
  self.assertEqual(value.type,self.e.type('List(Real)'))
  replay=Expressions(self.e,{}).elaborate(loads(dumps(value.tree)))
  self.assertEqual(replay.lean,value.lean)
 def test_literal_inside_carrier_binding_lambda_roundtrip(self):
  type_declaration('Type Large():',['Universe: 2','Classifies: 1','Means: Type 1','Render latex: L'],self.e)
  notation('Notation zero vector(n):',['Let n: Natural','Returns: Vector(n,Complex)','Means: fun _ => 0','Literal: 0','Render latex: 0'],self.e)
  scope={'n':Expr('n','n',self.e.type('Natural'),tree=['Local','n'])}
  value=Expressions(self.e,scope).parse('function(A: Large,function(x: A,(0: Vector(n,Complex))))')
  replay=Expressions(self.e,scope).elaborate(loads(dumps(value.tree)))
  self.assertEqual(replay.type,value.type);self.assertEqual(replay.lean,value.lean)

if __name__=='__main__':unittest.main()

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
