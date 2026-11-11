# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from cleanlang.core import CleanError,Environment,parse,lean,normalize_layout
from cleanlang.modules import load_module
from cleanlang.syntax import document
ROOT=Path(__file__).resolve().parents[1]

class AssumptionBlocks(unittest.TestCase):
 def setUp(self):
  self.env=Environment();load_module(ROOT/'library/standard.clean',self.env)
  self.env.sources.declare('local',{'kind':'other','label':'Local','title':'Assumption block tests'},ROOT)
 def source(self,assume):
  return 'Result identity:\n  Attribution: local; identity; original\n  Let x: Real\n'+assume+'\n  Conclude: x = x\n'
 def test_independent_tree_and_line(self):
  result=parse(self.source('  Assume reflexive:\n    x = x'),self.env)[0]
  self.assertEqual(result.clauses[1].label,'reflexive')
  self.assertEqual(result.clauses[1].line,4)
  self.assertEqual(result.clauses[1].value.tree,['Operator','=', ['Local','x'],['Local','x']])
 def test_inline_block_targets_equal(self):
  inline=lean(parse(self.source('  Assume reflexive: x = x'),self.env),self.env,[])
  for width in [2,3,5,8]:
   source=self.source('  aSsUmE reflexive:\n'+' '*(2+width)+'x = x')
   self.assertEqual(lean(parse(source,self.env),self.env,[]),inline)
 def test_comments_and_blank_lines(self):
  source=self.source('  Assume reflexive: -- label\n\n    /- note -/ x = x -- body')
  self.assertEqual(parse(source,self.env)[0].clauses[1].value.tree,['Operator','=', ['Local','x'],['Local','x']])
 def test_operator_continuation(self):
  source=self.source('  Assume reflexive:\n    x = x and\n    x = x')
  self.assertEqual(parse(source,self.env)[0].clauses[1].value.tree,['Operator','∧',['Operator','=', ['Local','x'],['Local','x']],['Operator','=', ['Local','x'],['Local','x']]])
 def test_context_inheritance(self):
  source='Context shared:\n  Let x: Real\n  Assume reflexive:\n    x = x\n  Result identity:\n    Attribution: local; identity; original\n    Conclude: x = x\n'
  result=parse(source,self.env)[0]
  self.assertEqual(result.clauses[1].line,3)
  self.assertEqual(result.clauses[1].label,'reflexive')
 def test_parenthesized_comma_is_not_a_list(self):
  source=self.source('  Assume reflexive:\n    for every(y: Real,y = y)')
  self.assertEqual(parse(source,self.env)[0].clauses[1].value.tree,['Forall','y','Real',['Operator','=', ['Local','y'],['Local','y']]])
 def test_bad_blocks_reject_before_elaboration(self):
  for clause in ['  Assume reflexive:', '  Assume reflexive: x = x\n    x = x', '  Assume reflexive:\n    x = x, other: x = x', '  Assume reflexive:\n    x = x\n      x = x']:
   with self.subTest(clause=clause),self.assertRaises(CleanError):document(normalize_layout(self.source(clause)))
 def test_nonproposition_rejected(self):
  with self.assertRaisesRegex(CleanError,'condition'):parse(self.source('  Assume reflexive:\n    x'),self.env)
 def test_duplicate_names_rejected(self):
  with self.assertRaisesRegex(CleanError,'Duplicate'):parse(self.source('  Assume reflexive:\n    x = x\n  Assume reflexive: x = x'),self.env)

if __name__=='__main__':unittest.main()

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
