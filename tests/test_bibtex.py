import importlib.util
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

from cleanlang.attribution import Sources
from cleanlang.core import CleanError, Environment, bibliography, lean
from cleanlang.modules import load_document

AVAILABLE = importlib.util.find_spec('pybtex') is not None
ROOT = Path(__file__).resolve().parents[1]


class MissingBibtexTests(unittest.TestCase):
    def test_actionable_optional_dependency_error(self):
        original = __import__
        def without_pybtex(name, *args, **kwargs):
            if name.startswith('pybtex'):
                raise ImportError('not installed')
            return original(name, *args, **kwargs)
        with patch('builtins.__import__', side_effect=without_pybtex):
            with self.assertRaisesRegex(ValueError, 'bibtex extra'):
                Sources().import_bibtex('not-read.bib')


@unittest.skipUnless(AVAILABLE, 'install the bibtex extra')
class BibtexTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.bib = self.root / 'refs.bib'
        self.sources = Sources()

    def test_macros_braces_accents_and_raw_provenance(self):
        self.bib.write_text(r'''@string{press = "SIAM"}
@book{Example:2001,
 title = {A {Matrix} study}, author = {G{\"o}del, Kurt and Stewart, G. W.},
 publisher = press # " Press", year = 2001, doi = {10.example/test}
}''')
        self.sources.import_bibtex(self.bib)
        entry = self.sources.entries['Example:2001']
        self.assertEqual(entry['title'], 'A Matrix study')
        self.assertIn('Gödel', entry['author'])
        self.assertEqual(entry['publisher'], 'SIAM Press')
        self.assertEqual(entry['bibtex']['fields']['title'], 'A {Matrix} study')
        self.assertEqual(len(entry['bibtex']['sha256']), 64)
        self.assertEqual(entry['label'], 'Example:2001')

    def test_same_path_deduplicates_but_distinct_files_conflict(self):
        self.bib.write_text('@book{a,title={A}}')
        self.sources.import_bibtex(self.bib)
        self.sources.import_bibtex(self.root / '.' / 'refs.bib')
        self.assertEqual(len(self.sources.entries), 1)
        other = self.root / 'other.bib'
        other.write_text(self.bib.read_text())
        with self.assertRaisesRegex(ValueError, 'Duplicate source'):
            self.sources.import_bibtex(other)

    def test_duplicate_entries_and_malformed_input_fail_atomically(self):
        for text in ['@book{a,title={A}} @book{a,title={B}}',
                     '@book{a,title={A}', '@book{a,title={A},title={B}}',
                     '@book{a,title={A}} @book{b,year=2001}']:
            with self.subTest(text=text):
                self.bib.write_text(text)
                with self.assertRaises(ValueError):
                    self.sources.import_bibtex(self.bib)
                self.assertEqual(self.sources.entries, {})
                self.assertEqual(self.sources.loaded_bibtex, set())

    def test_source_conflict_in_both_orders(self):
        self.bib.write_text('@book{a,title={A}}')
        self.sources.declare('a', {'kind':'other','label':'A','title':'A'}, self.root)
        with self.assertRaisesRegex(ValueError, 'Duplicate source'):
            self.sources.import_bibtex(self.bib)
        other = Sources()
        other.import_bibtex(self.bib)
        with self.assertRaisesRegex(ValueError, 'Duplicate source'):
            other.declare('a', {'kind':'other','label':'A','title':'A'}, self.root)

    def test_unhandled_inheritance_is_explicit(self):
        for field in ['crossref', 'xdata']:
            self.bib.write_text('@book{a,title={A},'+field+'={parent}}')
            with self.assertRaisesRegex(ValueError, 'inheritance is not yet supported'):
                self.sources.import_bibtex(self.bib)

    def test_missing_file(self):
        with self.assertRaises(FileNotFoundError):
            self.sources.import_bibtex(self.bib)

    def test_bibliography_does_not_execute_preamble(self):
        self.bib.write_text(r'@preamble{"\input{not-a-file}"} @book{a,title={A \unknown{B}}}')
        self.sources.import_bibtex(self.bib)
        self.assertEqual(set(self.sources.entries), {'a'})
        self.assertIn('unknown', self.sources.entries['a']['title'])

    def test_case_insensitive_import_relative_to_module(self):
        self.bib.write_text('@book{Paper:1,title={A}}')
        (self.root/'vocabulary.clean').write_text('iMPORT bIBtEX "refs.bib"\n')
        doc = self.root/'result.clean'
        doc.write_text(f'''Import "{ROOT / 'library/types.clean'}"
Import "vocabulary.clean"
Result reflexivity:
  Attribution: Paper:1; Example 1; adapted
  Let x: Real
  Conclude: x = x
''')
        env = Environment()
        results = load_document(doc, env)
        self.assertEqual(env.sources.resolve(results[0].attribution)['source_key'], 'Paper:1')
        self.assertNotIn('refs.bib', lean(results, env, []))
        self.assertIn('Paper:1', bibliography(results, env))
        doc.write_text(doc.read_text()+'Import BibTeX "refs.bib"\n')
        with self.assertRaisesRegex(CleanError, 'precede results'):
            load_document(doc, Environment())

    def test_checked_in_specimen(self):
        env = Environment()
        results = load_document(ROOT / 'examples/bibtex.clean', env)
        self.assertEqual(len(results), 1)
        self.assertEqual(env.sources.entries['stewart2001']['kind'], 'book')
        self.assertEqual(results[0].attribution['reference'], 'Theorem 1.10, page 9')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
