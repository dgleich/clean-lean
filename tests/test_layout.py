import tempfile
import unittest
from pathlib import Path

from cleanlang.core import CleanError, Environment, lean, parse
from cleanlang.modules import load_document
from support import standard_environment

ROOT = Path(__file__).resolve().parents[1]


class LayoutTests(unittest.TestCase):
    def setUp(self):
        self.env = standard_environment()

    def result(self, width=4, nested=4):
        p = ' ' * width
        q = p + ' ' * nested
        return ('Result identity:\n' + p + 'Attribution: mathlib; Matrix.det_transpose\n'
                + p + 'Let x: Real\n' + p + 'Conclude:\n' + q + 'x = x\n')

    def output(self, source):
        return lean(parse(source, self.env), self.env, [])

    def test_widths_preserve_proposition(self):
        expected = self.output(self.result())
        for width in [2, 3, 5, 8]:
            for nested in [2, 3, 7]:
                with self.subTest(width=width, nested=nested):
                    self.assertEqual(expected, self.output(self.result(width, nested)))

    def test_sibling_blocks_can_choose_different_widths(self):
        source = self.result(2, 3) + self.result(7, 2).replace('identity:', 'second:')
        self.assertEqual(len(parse(source, self.env)), 2)

    def test_nested_contexts_with_different_widths(self):
        source = '''Context outer:
  Let x: Real
  Context inner:
     Let y: Real
     Result identity:
          Attribution: mathlib; Matrix.det_transpose
          Conclude:
            x + y = x + y
'''
        result = parse(source, self.env)[0]
        self.assertEqual(len(result.contexts), 2)
        self.assertEqual(result.line, 5)
        self.assertEqual([c.line for c in result.clauses], [2, 4])

    def test_one_space_indent_and_unknown_dedent_rejected(self):
        with self.assertRaisesRegex(CleanError, 'at least two'):
            parse(self.result(1), self.env)
        with self.assertRaisesRegex(CleanError, 'dedent'):
            parse(self.result().replace('    Let x', '  Let x'), self.env)

    def test_unexpected_deeper_sibling_rejected(self):
        with self.assertRaisesRegex(CleanError, 'Unexpected nesting'):
            parse(self.result().replace('    Let x', '      Let x'), self.env)

    def test_comments_and_blank_lines_do_not_change_scope(self):
        source = self.result(3, 2).replace('   Let x', ' # arbitrarily aligned comment\n \n   Let x')
        self.assertEqual(self.output(source), self.output(self.result(3, 2)))

    def test_tabs_rejected_even_in_comments_and_blank_lines(self):
        for suffix in ['\t\n', '#\tcomment\n']:
            with self.assertRaisesRegex(CleanError, 'tabs'):
                parse(self.result() + suffix, self.env)

    def test_parenthesized_local_expression(self):
        source = '''Result identity:
  Attribution: mathlib; Matrix.det_transpose
  Let x: Real
  Let y = (
      x +
        (x * x)
  )
  Conclude: y = x + x*x
'''
        flat = source.replace('(\n      x +\n        (x * x)\n  )', '(x + (x * x))')
        self.assertEqual(self.output(source), self.output(flat))
        self.assertEqual(parse(source, self.env)[0].clauses[1].line, 4)

    def test_conclusion_continuation_and_following_error_line(self):
        source = self.result(2, 2).replace('    x = x', '    (x +\n         x) = (x + x)')
        self.output(source)
        with self.assertRaisesRegex(CleanError, 'line 10:.*Unknown name'):
            parse(source + '\nResult broken:\n  Attribution: mathlib; Matrix.det_transpose\n  Let y = unknown\n  Conclude: y = 0', self.env)

    def test_trailing_operator_infers_continuation(self):
        source = self.result(2, 2).replace('  Conclude:', '  Let y = x +\n    x *\n        x\n  Conclude:').replace('    x = x', '    y = x + x*x')
        expected = source.replace('x +\n    x *\n        x', 'x + x*x')
        self.assertEqual(self.output(source), self.output(expected))
        logical = self.result(2, 2).replace('    x = x', '    x = x and\n      x = x')
        self.assertEqual(self.output(logical), self.output(logical.replace('and\n      ', 'and ')))

    def test_operator_cannot_consume_next_clause(self):
        for source in [
            self.result(2, 2).replace('  Conclude:', '  Let y = x +\n  Conclude:'),
            self.result(2, 2).replace('  Conclude:', '  Let y = x +\n    Let z = x\n  Conclude:'),
        ]:
            with self.assertRaisesRegex(CleanError, 'continued expression'):
                parse(source, self.env)
        with self.assertRaisesRegex(CleanError, 'unfinished expression'):
            parse('Result identity:\n  Let x = 1 +', self.env)

    def test_complete_expression_does_not_infer_continuation(self):
        with self.assertRaisesRegex(CleanError, 'Unexpected nesting'):
            parse(self.result(2, 2).replace('  Conclude:', '  Let y = x\n    + x\n  Conclude:'), self.env)

    def test_unclosed_parenthesis_and_continuation_tabs(self):
        with self.assertRaisesRegex(CleanError, 'line 3: unclosed'):
            parse('Result identity:\n  Attribution: mathlib; Matrix.det_transpose\n  Let x = (\n    1', self.env)
        with self.assertRaisesRegex(CleanError, 'tabs'):
            parse('Result identity:\n  Let x = (\n\t1)', self.env)

    def test_module_widths_continued_signature_and_opaque_render(self):
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            (root / 'vocabulary.clean').write_text(f'''Import "{ROOT / 'library/types.clean'}"
Import "{ROOT / 'library/sources.clean'}"
Notation identity(x):
   Let x: Vector(
       2,
     Real)
   Returns: Vector(2,Real)
   Means: x
   Render: (open parenthesis {{x}}
''')
            (root / 'main.clean').write_text('''Import "vocabulary.clean"
Result identity:
  Attribution: mathlib; Matrix.det_transpose
  Let x: Vector(2,Real)
  Conclude: identity(x) = identity(x)
''')
            env = Environment()
            results = load_document(root / 'main.clean', env)
            self.assertEqual(len(results), 1)
            self.assertEqual(results[0].clauses[0].line, 4)
            (root / 'vocabulary.clean').write_text('#\ttab\n')
            with self.assertRaisesRegex(CleanError, 'vocabulary.clean: line 1: tabs'):
                load_document(root / 'main.clean', Environment())
