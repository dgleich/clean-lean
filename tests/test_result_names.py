# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
from pathlib import Path
import tempfile,unittest
from cleanlang.core import Environment,CleanError,lean
from cleanlang.modules import load_document
ROOT=Path(__file__).resolve().parents[1]
TITLES=['example','theorem','def','namespace','end','match','by','where','if','else','κ','ordinary result']

def source(titles):
 return f'Import "{ROOT}/library/operators.clean"\nSource local:\n  Kind: other\n  Label: Local\n  Title: Result identifiers\n'+''.join(
  f'Result {title}:\n  Attribution: local; identifier; original\n  Let x: Real\n  Conclude: x = x\n' for title in titles)

def load(titles):
 with tempfile.TemporaryDirectory() as d:
  p=Path(d)/'Names.clean';p.write_text(source(titles))
  e=Environment();return e,load_document(p,e)

class ResultNames(unittest.TestCase):
 def test_keyword_and_unicode_names_are_quoted_without_renaming(self):
  e,rs=load(TITLES);target=lean(rs,e,[])
  self.assertEqual([r.name for r in rs],[*TITLES[:-1],'ordinary_result'])
  for name in [*TITLES[:-1],'ordinary_result']:
   self.assertIn(f'def «{name}» : Prop :=',target)
 def test_existing_normalization_collision_is_not_hidden(self):
  with self.assertRaisesRegex(CleanError,'Duplicate'):
   load(['ordinary result','ordinary_result'])
 def test_identifier_delimiters_are_not_accepted_source_titles(self):
  with self.assertRaises(CleanError):load(['bad»name'])

if __name__=='__main__':unittest.main()

# generated: gpt-6 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
