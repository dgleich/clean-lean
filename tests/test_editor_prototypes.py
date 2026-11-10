# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Lexical display checks; these never certify experimental syntax as accepted."""
from pathlib import Path
import html,importlib.util,re,unittest
ROOT=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('prototype_review',ROOT/'tools/build_review.py')
review=importlib.util.module_from_spec(spec);spec.loader.exec_module(review)

class EditorPrototypeDisplay(unittest.TestCase):
 def test_named_block_header(self):
  rendered=review.highlight('  aSsUmE zero contents:')
  self.assertIn('<span class="keyword">aSsUmE</span>',rendered)
  self.assertIn('<span class="name">zero contents</span>',rendered)
 def test_classifier_metadata(self):
  rendered=review.highlight('  cLaSsIfIeS: 1')
  self.assertIn('<span class="keyword">cLaSsIfIeS</span>',rendered)
  self.assertIn('<span class="string"> 1</span>',rendered)
 def test_literal_metadata(self):
  rendered=review.highlight('  lItErAl: 0')
  self.assertIn('<span class="keyword">lItErAl</span>',rendered)
  self.assertIn('<span class="string"> 0</span>',rendered)
 def test_annotation_digits_and_nested_colon(self):
  rendered=review.highlight('  Assume positive((0: Vector(V.size,Complex)))')
  self.assertIn('<span class="number">0</span>',rendered)
  self.assertNotIn('class="name"',rendered)
 def test_text_comments_and_prose_boundaries(self):
  source='  Assume zero:\n    v = (0: Vector(n,Complex)) -- note\nText:\n  Literal: 0\n'
  rendered=review.highlight_source(source)
  self.assertIn('<span class="comment">-- note</span>',rendered[1])
  self.assertNotIn('class="keyword"',rendered[3])
  for before,after in zip(source.splitlines(),rendered):
   self.assertEqual(html.unescape(re.sub('<[^>]*>','',after)),before)

if __name__=='__main__':unittest.main()

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
