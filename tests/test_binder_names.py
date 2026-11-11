# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
from pathlib import Path
import tempfile,unittest
from cleanlang.core import Environment,CleanError,lean
from cleanlang.modules import load_document
from cleanlang.lean_identifiers import quoted
ROOT=Path(__file__).resolve().parents[1]
class BinderNames(unittest.TestCase):
 def setUp(self):
  self.e=Environment();self.rs=load_document(ROOT/'studies/identifier-quoting/Keywords.clean',self.e)
 def test_source_names_and_trees_are_preserved(self):
  r=self.rs[0];self.assertEqual(r.clauses[0].names,['example'])
  self.assertEqual(r.conclusion.tree,['Call','reflexive keyword',[['Local','example']]])
 def test_local_binder_and_uses_match(self):
  target=lean(self.rs,self.e,[])
  self.assertIn('∀ («example» :',target)
  self.assertIn('let «match» :',target)
  self.assertIn('(«match») (',target)
 def test_parameter_body_uses_quoted_identifier(self):
  key=self.e.data['functions']['identity keyword']['native_binding']
  self.assertIn('(«example» :',self.e.notation_definitions[key])
  self.assertTrue(self.e.notation_definitions[key].rstrip().endswith('«example»'))
 def test_opaque_native_body_is_not_rewritten(self):
  spec=self.e.data['types']['Items']
  self.assertIn('List «example»',spec['native_declaration'])
 def test_quoted_target_does_not_change_latex_name(self):
  self.assertEqual(self.rs[0].clauses[0].names,['example'])
  self.assertNotIn('«',self.rs[0].conclusion.tex)
 def test_quote_rejects_delimiters(self):
  for name in ['', 'a»b','a«b','a\nb','a\rb']:
   with self.assertRaises(CleanError):quoted(name)

if __name__=='__main__':unittest.main()

# generated: gpt-6 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
