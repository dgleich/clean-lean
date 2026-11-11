# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
import importlib.util,json,tempfile,unittest
from unittest.mock import patch
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('progressive_review',ROOT/'tools/build_review.py')
review=importlib.util.module_from_spec(spec);spec.loader.exec_module(review)

class ProgressiveReview(unittest.TestCase):
 def setUp(self):
  self.directory=tempfile.TemporaryDirectory();self.addCleanup(self.directory.cleanup)
  self.root=Path(self.directory.name);(self.root/'library').mkdir()
  (self.root/'library/minimal.clean').write_text('Type Scalar():\n  Means: Unit\n  Render latex: S\n')
 def test_inventory_is_explicitly_pending(self):
  files=review.inventory(self.root)
  self.assertEqual(len(files),1);self.assertEqual(files[0]['status'],'Translation pending')
  self.assertEqual(files[0]['lean'],'');self.assertIsNone(files[0]['error'])
  review.translate(files[0],self.root)
  self.assertTrue(files[0]['status'].startswith('Translated'))
  self.assertIn('cleanType_Scalar',files[0]['lean'])
 def test_changed_source_does_not_get_a_stale_target(self):
  file=review.inventory(self.root)[0]
  (self.root/file['path']).write_text('changed after inventory')
  review.translate(file,self.root)
  self.assertEqual(file['status'],'Translation unavailable');self.assertEqual(file['lean'],'')
  self.assertIn('changed',file['error'])
 def test_changed_import_is_reported(self):
  (self.root/'library/use.clean').write_text('Import "minimal.clean"\n')
  files=review.inventory(self.root);sources={(self.root/f['path']).resolve():f['source'] for f in files}
  (self.root/'library/minimal.clean').write_text('Type Scalar():\n  Means: Nat\n  Render latex: S\n')
  file=next(f for f in files if f['path'].endswith('use.clean'));review.translate(file,self.root,sources)
  self.assertIn('Dependency changed',file['error']);self.assertEqual(file['lean'],'')
 def test_snapshot_roundtrip_preserves_source_and_pending_state(self):
  payload={'files':[{'source':'</script> & <x> \\u003c','status':'Translation pending'}],'complete':False}
  dest=self.root/'review.html';review.write_snapshot(payload,'/* REVIEW_DATA */',dest)
  text=dest.read_text();self.assertNotIn('</script>',text)
  self.assertEqual(json.loads(text),payload)
  self.assertFalse(dest.with_name('review.html.tmp').exists())
 def test_completed_collection_keeps_errors_visible(self):
  (self.root/'library/bad.clean').write_text('not a declaration')
  files=review.collect(self.root)
  self.assertFalse(any(f['status']=='Translation pending' for f in files))
  self.assertEqual(sum(f['error'] is not None for f in files),1)
 def test_proposed_study_is_readable_without_attempting_translation(self):
  study=self.root/'studies/topology';study.mkdir(parents=True)
  source='Import "Missing.clean"\nResult pending geometry:\n  Conclude: unimplemented syntax\n'
  (study/'Targets.clean.proposed').write_text(source)
  file=next(f for f in review.inventory(self.root) if f['path'].endswith('.proposed'))
  self.assertEqual(file['source'],source)
  self.assertEqual(file['symbols'][0]['name'],'pending geometry')
  self.assertEqual(file['imports'][0]['path'],'studies/topology/Missing.clean')
  self.assertTrue(file['highlighted'])
  with patch.object(review,'load_module',side_effect=AssertionError('draft must not load')), patch.object(review,'load_document',side_effect=AssertionError('draft must not load')):
   review.translate(file,self.root)
  self.assertEqual(file['status'],'Proposed syntax · no translation attempted')
  self.assertIsNone(file['error']);self.assertEqual(file['lean'],'')
 def test_proposed_suffix_does_not_hide_an_ordinary_translation_error(self):
  (self.root/'library/bad.clean').write_text('not a declaration')
  (self.root/'library/bad.clean.proposed').write_text('not a declaration')
  files={f['path']:f for f in review.collect(self.root)}
  self.assertEqual(files['library/bad.clean']['status'],'Translation unavailable')
  self.assertIsNotNone(files['library/bad.clean']['error'])
  self.assertEqual(files['library/bad.clean.proposed']['status'],'Proposed syntax · no translation attempted')

if __name__=='__main__':unittest.main()

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
