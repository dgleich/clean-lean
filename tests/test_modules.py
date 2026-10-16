from support import standard_environment
import tempfile
import unittest
from pathlib import Path
from cleanlang.core import Environment, CleanError, lean, latex
from cleanlang.modules import load_document

ROOT = Path(__file__).resolve().parents[1]
MODULE = (ROOT/'examples/modules/sorting.clean').read_text().replace('../../library/types.clean', str(ROOT/'library/types.clean'))
RESULT = (ROOT/'examples/notation.clean').read_text()
RESULT = RESULT[RESULT.index('Result '):]

class ModuleTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.reg = standard_environment()

    def load(self, text, module=MODULE):
        (self.root/'sorting.clean').write_text(module)
        path = self.root/'result.clean'
        path.write_text(text)
        return load_document(path, self.reg)

    def test_explicit_definition_does_not_use_camelcase_name(self):
        del self.reg.data['functions']['insertionSort']
        results = self.load('Import "sorting.clean"\n'+RESULT)
        output = lean(results, self.reg, [])
        self.assertIn('import Mathlib.Data.List.Sort', output)
        self.assertIn('List.insertionSort (· ≤ ·) xs', output)
        self.assertIn('insertion sort of ', latex(results, self.reg))
        self.assertEqual(results[0].line, 2)

    def test_import_required(self):
        with self.assertRaises(CleanError):
            self.load(RESULT)

    def test_inline_and_imported_equivalent(self):
        imported = self.load('Import "sorting.clean"\n'+RESULT)
        expected = lean(imported, self.reg, [])
        self.reg = standard_environment()
        inline = self.load(MODULE+'\n'+RESULT)
        self.assertEqual(expected, lean(inline, self.reg, []))

    def test_diamond_import(self):
        (self.root/'other.clean').write_text('Import "sorting.clean"\n')
        self.load('Import "other.clean"\nImport "sorting.clean"\n'+RESULT)
        self.assertEqual(sum('List.insertionSort (· ≤ ·) xs' in body for body in self.reg.notation_definitions.values()), 1)

    def test_cycle(self):
        with self.assertRaisesRegex(CleanError, 'Cyclic'):
            self.load('Import "sorting.clean"\n'+RESULT, 'Import "result.clean"')

    def test_collision(self):
        with self.assertRaisesRegex(CleanError, 'Duplicate visible'):
            self.load(MODULE+'\n'+MODULE+'\n'+RESULT)

    def test_legacy_name_collision(self):
        with self.assertRaisesRegex(CleanError, 'Duplicate visible'):
            self.load(MODULE.replace('insertion sort(xs)', 'insertionSort(xs)')+'\n'+RESULT)

    def test_unknown_placeholder(self):
        with self.assertRaisesRegex(CleanError, 'rendering parameter'):
            self.load('Import "sorting.clean"\n'+RESULT, MODULE.replace('{xs}', '{ys}'))

    def test_missing_signature(self):
        with self.assertRaisesRegex(CleanError, 'Declare parameters'):
            self.load('Import "sorting.clean"\n'+RESULT, MODULE.replace('    Returns: List(Natural)\n', ''))

    def test_wrong_argument_type(self):
        with self.assertRaisesRegex(CleanError, 'Expected List'):
            self.load('Import "sorting.clean"\n'+RESULT.replace('Let xs: List(Natural)', 'Let xs: Natural'))

    def test_case_insensitive_keywords(self):
        module = MODULE.replace('Notation', 'NOTATION').replace('Import Lean', 'IMPORT LEAN').replace('Let ', 'let ').replace('Returns:', 'RETURNS:')
        self.load('IMPORT "sorting.clean"\n'+RESULT, module)

    def test_import_after_result_rejected(self):
        with self.assertRaisesRegex(CleanError, 'precede results'):
            self.load(MODULE+'\n'+RESULT+'\nImport "sorting.clean"')

    def test_imported_results_rejected(self):
        with self.assertRaisesRegex(CleanError, 'only declarations and imports'):
            self.load('Import "sorting.clean"\n'+RESULT, MODULE+'\n'+RESULT)

    def test_render_escaping(self):
        results = self.load('Import "sorting.clean"\n'+RESULT, MODULE.replace('insertion sort of', 'sort & 100% of'))
        self.assertIn(r'sort \& 100\% of', latex(results, self.reg))

    def test_missing_file(self):
        with self.assertRaises(FileNotFoundError):
            self.load('Import "missing.clean"\n'+RESULT)
