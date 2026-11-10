# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest,json,dataclasses
import cleanlang
from cleanlang.core import Environment,Expr,Expressions,lean,CleanError
from cleanlang.modules import load_document
from cleanlang.proof_types import index
from cleanlang.dependent_functions import index_tree
from cleanlang.retained_codec import loads
ROOT=Path(cleanlang.__file__).resolve().parents[1]

class CombinedInteractions(unittest.TestCase):
 @classmethod
 def setUpClass(cls):
  cls.env=Environment();cls.results=load_document(ROOT/'studies/composed-language/Interactions.clean',cls.env)
 def test_named_block_retains_selected_literal(self):
  clause=self.results[0].clauses[-1]
  self.assertEqual(clause.label,'zero')
  tree=clause.value.tree
  self.assertEqual(tree[:2],['Operator','='])
  self.assertEqual(tree[2],['Local','v'])
  self.assertEqual(tree[3][0],'BoundLiteral')
  self.assertEqual(tree[3][3],'vector zero')
  self.assertEqual(tree[3][5],[['n','explicit',['Local','n']]])
 def test_inherited_block_preserves_projected_dimension(self):
  clause=self.results[1].clauses[-1]
  self.assertEqual(clause.label,'zero contents')
  self.assertEqual(clause.value.tree[3][5],[['n','explicit',['Projection',['Local','V'],'size']]])
  self.assertEqual(len(self.results[1].contexts),1)
 def test_stored_proof_payload_keeps_retained_literal(self):
  e=self.env
  scope={'n':Expr('n','n',e.type('Natural'),tree=['Local','n'])}
  scope['v']=Expr('v','v',e.type('Vector(n,Complex)',scope),tree=['Local','v'])
  condition=Expressions(e,scope).parse('v = (0: Vector(n,Complex))')
  proof=index(condition,e,scope)
  payload=loads(proof.syntax)
  self.assertIn('BoundLiteral',repr(payload))
  empty=dataclasses.replace(proof,resolved=None)
  self.assertEqual(index_tree(empty),payload)
 def test_unannotated_zero_does_not_silently_gain_inference(self):
  e=self.env;scope={'n':Expr('n','n',e.type('Natural'),tree=['Local','n'])}
  scope['v']=Expr('v','v',e.type('Vector(n,Complex)',scope),tree=['Local','v'])
  with self.assertRaises(CleanError):Expressions(e,scope).parse('v = 0')

if __name__=='__main__':unittest.main()

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
