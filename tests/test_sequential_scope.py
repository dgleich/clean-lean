# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
from pathlib import Path
import tempfile,unittest
from cleanlang.core import Environment,CleanError,lean,latex
from cleanlang.modules import load_document
ROOT=Path(__file__).resolve().parents[1]
BASE=f'Import "{ROOT}/studies/sequential-scope/Base.clean"\n'
SOURCE='Source local:\n  Kind: other\n  Label: test\n  Title: test\n'
RESULT='Result first:\n  Attribution: local; test; original\n  Let T: Type\n  Let x: T\n  Conclude: x = x\n'
LATE='Type T():\n  Means: Real\n  Render latex: late-type\n'
class SequentialScope(unittest.TestCase):
 def load(self,text):
  with tempfile.TemporaryDirectory() as td:
   p=Path(td)/'Statement.clean';p.write_text(text);e=Environment();return load_document(p,e),e
 def test_later_global_type_does_not_reinterpret_local_carrier(self):
  rs,e=self.load(BASE+SOURCE+RESULT+LATE)
  target=lean(rs,e,[])
  self.assertIn('∀ (x : T)',target);self.assertNotIn('∀ (x : Real)',target)
  self.assertNotIn('late-type',latex(rs,e))
  self.assertNotIn('T',rs[0].environment.data['types'])
 def test_context_keeps_its_snapshot(self):
  result=RESULT.replace('  Let T: Type\n','').replace('  Let x: T\n','')
  context='Context carrier:\n  Let T: Type\n  Let x: T\n'+''.join('  '+line+'\n' for line in result.splitlines())
  rs,e=self.load(BASE+SOURCE+context+LATE)
  self.assertIn('∀ (x : T)',lean(rs,e,[]));self.assertNotIn('late-type',latex(rs,e))
  self.assertEqual(len(rs[0].contexts),1)
 def test_later_import_cannot_repair_earlier_unknown_function(self):
  first='Result first:\n  Attribution: local; test\n  Let x: Scalar\n  Conclude: absolute value(x) = x\n'
  with self.assertRaisesRegex(CleanError,'Unknown function: absolute value'):
   self.load(BASE+SOURCE+first+f'Import "{ROOT}/studies/sequential-scope/Operations.clean"\n')
 def test_later_source_cannot_repair_earlier_attribution(self):
  with self.assertRaisesRegex(CleanError,'Unknown attribution source'):
   self.load(BASE+RESULT+SOURCE)
 def test_later_declaration_is_available_to_later_result(self):
  second=RESULT.replace('first','second').replace('  Let T: Type\n','')
  rs,e=self.load(BASE+SOURCE+RESULT+LATE+second)
  target=lean(rs,e,[])
  self.assertIn('∀ (x : T)',target);self.assertIn('∀ (x : Real)',target)
  self.assertIsNot(rs[0].environment,rs[1].environment)
 def test_adjacent_results_share_snapshot_not_mutable_loader(self):
  rs,e=self.load(BASE+SOURCE+RESULT+RESULT.replace('first','second'))
  self.assertIs(rs[0].environment,rs[1].environment)
  self.assertIsNot(rs[0].environment,e)
  e.data['types']['T']={'args':[],'lean':'Real','latex':'changed'}
  self.assertIn('∀ (x : T)',lean(rs,e,[]))
 def test_duplicate_result_names_still_rejected_across_import(self):
  with self.assertRaisesRegex(CleanError,'Duplicate result name'):
   self.load(BASE+SOURCE+RESULT+BASE+RESULT)
 def test_nested_import_is_not_enabled(self):
  with self.assertRaises(CleanError):self.load(BASE+SOURCE+RESULT+'  Import "missing.clean"\n')

 def test_combined_output_uses_each_documents_statement_scope(self):
  from cleanlang.__main__ import combine
  first,a=self.load(BASE+SOURCE+RESULT)
  second,b=self.load(BASE+SOURCE+LATE+RESULT.replace('first','second').replace('  Let T: Type\n',''))
  target=lean([*first,*second],combine([a,b]),[])
  self.assertIn('∀ (x : T)',target);self.assertIn('∀ (x : Real)',target)

# generated: gpt-6 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
