# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Local/module type collision gates for the integrated compiler."""
from pathlib import Path
import unittest
from cleanlang.core import Environment,Expr,Type,Expressions,CleanError
from cleanlang.modules import load_module
ROOT=Path(__file__).resolve().parents[1]

class TypeIdentity(unittest.TestCase):
    def setUp(self):
        self.env = Environment()
        load_module(ROOT / 'tests/fixtures/type_identity.clean', self.env)
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

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
