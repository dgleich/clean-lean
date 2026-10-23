"""Prototype coverage; full canonical-target/AST conformance remains separately tracked."""
import tempfile
import unittest
from pathlib import Path
from cleanlang.core import Environment, CleanError, Expressions, Expr, Type
from cleanlang.modules import load_module

ROOT = Path(__file__).resolve().parents[1]
BASE = f'Import "{ROOT}/library/analysis.clean"\n'
IDENTITY = 'Define identity(x):\n  Let x: Real\n  Returns: Real\n  Equals: x\n'

class DefinitionTests(unittest.TestCase):
    def load(self, text):
        env = Environment()
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory)/'test.clean'
            path.write_text(BASE+text)
            load_module(path, env)
        return env

    def test_independent_identity_target(self):
        env = self.load(IDENTITY)
        self.assertEqual(env.definitions['identity']['tree'], ['Local','x'])
        key = env.definitions['identity']['key']
        self.assertEqual(env.notation_definitions[key],
                         f'noncomputable def {key}  (x : ℝ) : ℝ :=\n  x\n')

    def test_fields_reordered(self):
        expected = self.load(IDENTITY).definitions['identity']['key']
        for fields in ['  Equals: x\n  Returns: Real\n  Let x: Real\n',
                       '  Returns: Real\n  Let x be a Real\n  Equals:\n    x\n']:
            self.assertEqual(self.load('Define identity(x):\n'+fields).definitions['identity']['key'], expected)

    def test_grouped_lets_and_composition(self):
        env = self.load('Define energy(x, y):\n  Let x, y: Real\n  Returns: Real\n  Equals: square(x) + square(y)\n')
        self.assertEqual(env.definitions['energy']['tree'],
            ['Operator', '+', ['Call', 'square', [['Local','x']]], ['Call','square',[['Local','y']]]])
        self.assertIn('cleanDefine_', env.notation_definitions[env.definitions['energy']['key']].split(':=')[1])

    def test_default_render(self):
        env = self.load(IDENTITY)
        x = Expr('x','x',Type('Real'))
        self.assertEqual(env.call('identity',[x]).tex, r'\operatorname{identity}(x)')
        self.assertEqual(env.call('squared distance',[x,x]).tex, r'\operatorname{squared\ distance}(x, x)')

    def test_inline_adapter(self):
        env = self.load(IDENTITY.replace('Equals: x','From Lean: x'))
        self.assertEqual(env.definitions['identity']['implementation'], 'from lean')

    def test_continuation_in_block(self):
        env = self.load(IDENTITY.replace('Equals: x','Equals:\n    x +\n    x'))
        self.assertEqual(env.definitions['identity']['body'], 'x + x')

    def test_keyword_capitalization(self):
        self.load(IDENTITY.replace('Define','DEFINE').replace('Equals','eQuAlS').replace('Let','LET'))

    def test_invalid_definitions(self):
        variants = [
            IDENTITY.replace('Equals: x', 'Equals: x\n  From Lean: x'),
            IDENTITY.replace('Equals: x', 'Equals: x\n  Equals: x'),
            IDENTITY.replace('Equals: x', 'Equals:'),
            IDENTITY.replace('Equals: x', 'Equals: missing(x)'),
            IDENTITY.replace('Equals: x', 'Equals: identity(x)'),
            IDENTITY.replace('Equals: x', 'Equals: x = x'),
            IDENTITY.replace('Equals: x', 'Equals: Real'),
            IDENTITY.replace('Equals: x', 'Equals: x\n    + x'),
            IDENTITY.replace('Equals: x', 'From Lean:\n    x'),
            IDENTITY.replace('Returns: Real\n', ''),
            IDENTITY.replace('Let x: Real', 'Let x: Real\n  Let x: Real'),
            IDENTITY.replace('Let x: Real', 'Let n: Natural\n  Let x: Real'),
            IDENTITY.replace('Equals: x', 'Equals: x\n  Render: {x}\n  Render latex: {x}'),
            IDENTITY + IDENTITY,
        ]
        for source in variants:
            with self.subTest(source=source), self.assertRaises(CleanError):
                self.load(source)

    def test_body_does_not_see_later_definition(self):
        with self.assertRaises(CleanError):
            self.load(IDENTITY.replace('Equals: x', 'Equals: later(x)') + IDENTITY.replace('identity','later'))

    def test_prior_parameter_scope(self):
        with self.assertRaises(CleanError):
            self.load('Define first(A):\n  Let A: Matrix(n,n,Complex)\n  Let n: Natural\n  Returns: Matrix(n,n,Complex)\n  Equals: A\n')

    def test_definition_attribution_checked(self):
        with self.assertRaises(CleanError):
            self.load(IDENTITY+'  Attribution: unknown; result\n')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
