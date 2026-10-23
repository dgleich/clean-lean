import importlib.util
import re
import unittest
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('build_review',ROOT/'tools/build_review.py')
review=importlib.util.module_from_spec(spec);spec.loader.exec_module(review)

class ReviewTests(unittest.TestCase):
    def test_source_markup_is_escaped(self):
        rendered=review.highlight('# </script><img src=x onerror=alert(1)>')
        self.assertNotIn('</script>',rendered)
        self.assertNotIn('<img',rendered)
        self.assertIn('&lt;/script&gt;',rendered)

    def test_highlighting_preserves_text(self):
        import html
        for source in ['Let μ be a Complex','Define f(x):','Attribution: mathlib; x; direct',
                       '  Equals: x + 2','  # <&>','  From Lean: x + x']:
            with self.subTest(source=source):
                self.assertEqual(html.unescape(re.sub('<[^>]*>','',review.highlight(source))),source)

    def test_opaque_fields_do_not_highlight_math(self):
        for source in ['Render latex: x^2 and y', 'Attribution: note; and', 'Means: x + 2']:
            self.assertNotIn('class="number"',review.highlight(source))
            self.assertNotIn('>and</span>',review.highlight(source))

    def test_import_navigation_and_fresh_targets(self):
        files={f['path']:f for f in review.collect()}
        sample=files['library/analysis.clean']
        self.assertIsNone(sample['error'])
        self.assertIn('cleanDefine_',sample['lean'])
        self.assertEqual(sample['imports'][0]['path'],'library/types.clean')
        self.assertTrue(any(s.get('leanName','').startswith('cleanDefine_') for s in sample['symbols']))
        self.assertEqual(len(sample['sha256']),64)
        for file in files.values():
            for imported in file['imports']:
                self.assertIn(imported['path'],files)

    def test_proposed_algorithms_are_not_claimed_translated(self):
        files={f['path']:f for f in review.collect()}
        for name in ('insertion-sort', 'heap-sort'):
            sample=files[f'examples/proposed/{name}.clean']
            self.assertEqual(sample['lean'], '')
            self.assertIn('Proposed syntax', sample['status'])
            self.assertTrue(any(s['kind']=='define' for s in sample['symbols']))

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
