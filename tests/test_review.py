# generated: gpt-6 2026-11-06 role=assisted; cached shared review fixture; see PROVENANCE.md
import importlib.util
from functools import cache
import re
import unittest
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('build_review',ROOT/'tools/build_review.py')
review=importlib.util.module_from_spec(spec);spec.loader.exec_module(review)

class ReviewTests(unittest.TestCase):
    @classmethod
    @cache
    def collected_files(cls):
        # Both navigation tests inspect the same immutable repository snapshot.
        return {f['path']:f for f in review.collect()}

    def test_source_markup_is_escaped(self):
        rendered=review.highlight('-- </script><img src=x onerror=alert(1)>')
        self.assertNotIn('</script>',rendered)
        self.assertNotIn('<img',rendered)
        self.assertIn('&lt;/script&gt;',rendered)

    def test_highlighting_preserves_text(self):
        import html
        for source in ['Let μ be a Complex','Define f(x):','Attribution: mathlib; x; direct',
                       '  Equals: x + 2','  -- <&>','  From Lean: x + x']:
            with self.subTest(source=source):
                self.assertEqual(html.unescape(re.sub('<[^>]*>','',review.highlight(source))),source)

    def test_opaque_fields_do_not_highlight_math(self):
        for source in ['Render latex: x^2 and y', 'Attribution: note; and', 'Means: x + 2']:
            self.assertNotIn('class="number"',review.highlight(source))
            self.assertNotIn('>and</span>',review.highlight(source))

    def test_unclosed_comment_remains_browsable(self):
        self.assertEqual(review.highlight_source('/-\n<unfinished>'), ['/-', '&lt;unfinished&gt;'])

    def test_comment_source_highlighting(self):
        lines = review.highlight_source('Let x: Real -- note\n/-\nignored <tag>\n-/\nMeans: #[1]')
        self.assertIn('<span class="comment">-- note</span>', lines[0])
        self.assertEqual(lines[2], '<span class="comment">ignored &lt;tag&gt;</span>')
        self.assertNotIn('class="comment"', lines[4])

    def test_inline_comment_keeps_following_code_visible(self):
        import html
        source = 'Let x: /- note -/ Real -- end'
        rendered = review.highlight_source(source)[0]
        self.assertIn('<span class="comment">/- note -/</span>', rendered)
        self.assertIn('Real', rendered.split('<span class="comment">/- note -/</span>')[1])
        self.assertEqual(html.unescape(re.sub('<[^>]*>', '', rendered)), source)

    def test_literate_payload_is_not_highlighted_as_clean_code(self):
        source='Text latex:\n  Result fake: -- prose\n"""\n/- literal\n"""'
        lines=review.highlight_source(source)
        self.assertIn('class="string"',lines[1])
        self.assertNotIn('class="comment"',lines[1])
        self.assertNotIn('class="keyword"',lines[3])

    def test_import_navigation_and_fresh_targets(self):
        files=self.collected_files()
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
        files=self.collected_files()
        for name in ('insertion-sort', 'heap-sort'):
            sample=files[f'examples/proposed/{name}.clean']
            self.assertEqual(sample['lean'], '')
            self.assertIn('Proposed syntax', sample['status'])
            self.assertTrue(any(s['kind']=='define' for s in sample['symbols']))

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
