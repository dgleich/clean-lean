# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Acceptance gates, intentionally failing until type identities are preserved.

Run with --compiler PATH to audit an isolated compiler stack. --native also
checks the generated statement against an independently authored Lean target.
Neither parser errors nor Lean compilation failures count as successful gates.
"""
from pathlib import Path
import argparse
import ast
import os
import subprocess
import sys
import tempfile
import unittest

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--compiler', type=Path, default=ROOT)
parser.add_argument('--native', action='store_true')
options = parser.parse_args()
sys.path.insert(0, str(options.compiler.resolve()))
from cleanlang.core import Environment, Expr, Type, Expressions, CleanError, lean
from cleanlang.modules import load_module, load_document


class TypeIdentity(unittest.TestCase):
    def setUp(self):
        self.env = Environment()
        load_module(HERE / 'Foundation.clean.proposed', self.env)
        self.locals = {
            'Real': Expr('Real', 'Real', Type('Type'), tree=['Local', 'Real'])
        }

    def test_neutral_type_parse(self):
        from cleanlang.syntax import parse, type_tree
        self.assertEqual(type_tree(parse('Real', 'type_ref')), ['Name', 'Real'])

    def test_local_and_module_are_distinct(self):
        self.assertNotEqual(self.env.type('Real', self.locals), self.env.type('Real'))

    def test_local_lean_rendering(self):
        local = self.env.type('Real', self.locals)
        self.assertEqual(self.env.render_type(local, 'lean'), 'Real')

    def test_local_precedes_module_alias(self):
        scope = {'Scalar': Expr('Scalar', 'Scalar', Type('Type'), tree=['Local', 'Scalar'])}
        local = self.env.type('Scalar', scope)
        self.assertEqual(self.env.render_type(local, 'lean'), 'Scalar')
        self.assertNotEqual(local, self.env.type('Scalar'))

    def test_module_type_survives_dependent_substitution(self):
        from cleanlang.dependent_functions import substitute
        real = self.env.type('Real')
        result = substitute(real, {'Real': self.env.type('Natural')}, self.env, {})
        self.assertEqual(result, real)

    def test_module_type_survives_structure_substitution(self):
        from cleanlang.structures import substitute_type
        real = self.env.type('Real')
        result = substitute_type(real, {'Real': self.env.type('Natural')}, self.env, {})
        self.assertEqual(result, real)

    def test_local_value_cannot_satisfy_module_real_argument(self):
        scope = dict(self.locals)
        scope['x'] = Expr('x', 'x', self.env.type('Real', scope), tree=['Local', 'x'])
        # Positive control: the declaration exists and its concrete call works.
        concrete = {'y': Expr('y', 'y', self.env.type('Real'), tree=['Local', 'y'])}
        Expressions(self.env, concrete).parse('real identity(y)')
        with self.assertRaises(CleanError):
            Expressions(self.env, scope).parse('real identity(x)')

    @unittest.skipUnless(options.native, 'Pass --native for exact Lean-target check')
    def test_exact_native_statement(self):
        env = Environment()
        results = load_document(HERE / 'Statements.clean.proposed', env)
        comparison = next(
            ast.literal_eval(node.value)
            for node in ast.parse((ROOT / 'tools/check_basic_targets.py').read_text()).body
            if isinstance(node, ast.Assign)
            and any(isinstance(t, ast.Name) and t.id == 'COMPARISON' for t in node.targets)
        )
        expected = '''
def expected_local_carrier : Prop := ∀ (Real : Type) (x : Real), x = x
theorem expected_local_carrier_proof : expected_local_carrier := by
  intro Real x
  rfl
'''
        native = lean(results, env, ['Lean']) + expected
        lake = os.environ.get('LAKE', '/home/claude/.elan/bin/lake')
        with tempfile.TemporaryDirectory(prefix='clean-type-identity-') as td:
            path = Path(td) / 'Identity.lean'
            path.write_text(native)
            control = subprocess.run([lake, 'env', 'lean', str(path)], cwd=ROOT,
                                     text=True, capture_output=True)
            self.assertEqual(control.returncode, 0, control.stdout + control.stderr)
            path.write_text(native + comparison + '\nsame_basic_target '
                            'CleanStatements.local_carrier_identity expected_local_carrier\n')
            checked = subprocess.run([lake, 'env', 'lean', str(path)], cwd=ROOT,
                                     text=True, capture_output=True)
            self.assertEqual(checked.returncode, 0, checked.stdout + checked.stderr)


if __name__ == '__main__':
    unittest.main(argv=[sys.argv[0]], verbosity=2)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
