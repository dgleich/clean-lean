# generated: gpt-6 2026-11-07 role=assisted; isolated local type prototype
"""Check semantic type preservation on a supplied isolated compiler checkout."""
from pathlib import Path
import ast
import copy
import os
import subprocess
import sys
import unittest

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
COMPILER = Path(sys.argv[1]).resolve()
sys.path.insert(0, str(COMPILER))
from cleanlang.core import Environment, Expr, Type, Expressions, lean, latex
from cleanlang.modules import load_module, load_document, type_declaration
from cleanlang.annotations import checked, replace, references, Annotation
from cleanlang.dependent_functions import substitute, type_key, tree_names
from cleanlang.inferred_conversion import reify


def setup():
    env = Environment()
    load_module(HERE / 'Foundation.clean.proposed', env)
    type_declaration('Type Proposition():', ['Means: Prop', 'Render latex: condition'], env)
    scope = {'Real': Expr('Real', 'Real', Type('Type'), tree=['Local', 'Real'])}
    type_declaration('Type FixedReal():', ['Equals: Real'], env)
    type_declaration('Type ConstantReal(T: Type):', ['Equals: Real'], env)
    type_declaration('Type IdentityType(T: Type):', ['Equals: T'], env)
    return env, scope


class Preservation(unittest.TestCase):
    def setUp(self):
        self.env, self.scope = setup()

    def test_closed_alias_uses_declaration_scope(self):
        self.assertEqual(self.env.type('FixedReal', self.scope), self.env.type('Real'))

    def test_constant_alias_does_not_capture_local(self):
        self.assertEqual(self.env.type('ConstantReal(Real)', self.scope), self.env.type('Real'))

    def test_parameter_alias_retains_local(self):
        self.assertEqual(self.env.type('IdentityType(Real)', self.scope),
                         self.env.type('Real', self.scope))

    def test_local_substitution_and_global_non_substitution(self):
        local = self.env.type('Real', self.scope)
        module = self.env.type('Real')
        replacements = {'Real': self.env.type('Natural')}
        self.assertEqual(substitute(local, replacements, self.env, {}), replacements['Real'])
        self.assertEqual(substitute(module, replacements, self.env, {}), module)

    def test_local_reference_retains_selected_lean_binder(self):
        scope = {'Real': Expr('fresh_carrier', 'Real', Type('Type'), tree=['Local', 'Real'])}
        renamed = self.env.type('Real', scope)
        self.assertNotEqual(renamed, self.env.type('Real', self.scope))
        self.assertEqual(self.env.render_type(renamed, 'lean'), 'fresh_carrier')
        self.assertEqual(type_key(renamed, ('fresh_carrier',)),
                         type_key(self.env.type('Real', self.scope), ('Real',)))

    def test_annotation_does_not_gain_local_references(self):
        module = checked('Real', self.env, {})
        self.assertEqual(references(module.typ, self.scope), set())
        self.assertEqual(tree_names(['TypeValue', module]), set())
        rebound = replace(module, {'Real': self.env.type('Natural')}, self.env, self.scope)
        self.assertEqual(rebound.typ, self.env.type('Real'))
        self.assertEqual(rebound.names, frozenset())

    def test_local_annotation_substitutes_semantically(self):
        local = checked('Real', self.env, self.scope)
        self.assertEqual(local.names, {'Real'})
        replaced = replace(local, {'Real': self.env.type('Natural')}, self.env, self.scope)
        self.assertEqual(replaced.typ, self.env.type('Natural'))
        self.assertEqual(replaced.names, frozenset())

    def test_module_reification_avoids_local_capture(self):
        result = reify(self.env.type('Real'), self.env, self.scope)
        self.assertIsInstance(result.tree[1], Annotation)
        self.assertEqual(self.env.type(result.tree[1], self.scope), self.env.type('Real'))
        self.assertEqual(result.lean, 'ℝ')

    def test_local_latex_does_not_use_module_template(self):
        local = self.env.type('Real', self.scope)
        from cleanlang.core import texid
        self.assertEqual(self.env.render_type(local, 'latex'), texid('Real'))
        self.assertNotEqual(self.env.render_type(local, 'latex'),
                            self.env.render_type(self.env.type('Real'), 'latex'))

    def test_semantic_annotation_survives_copy(self):
        annotation = checked('Real', self.env, self.scope)
        cloned = copy.deepcopy(annotation)
        self.assertEqual(cloned, annotation)
        self.assertNotEqual(cloned.typ, self.env.type('Real'))

    def test_sort_and_callable_classification_ignore_module_spelling(self):
        scope = {'Type': Expr('carrier', 'Type', Type('Type'), tree=['Local', 'Type'])}
        local = self.env.type('Type', scope)
        self.assertEqual(self.env.sort_level(local), 1)
        self.assertFalse(self.env.is_function_type(local))


if __name__ == '__main__':
    result = unittest.TextTestRunner(verbosity=2).run(
        unittest.defaultTestLoader.loadTestsFromTestCase(Preservation))
    if not result.wasSuccessful():
        raise SystemExit(1)
    env, scope = setup()
    results = load_document(HERE / 'Statements.clean.proposed', env)
    quantified = Expressions(env, {}).parse('for every (T: Type, for every (x: T, x=x))')
    alias = env.render_type(env.type('FixedReal', scope), 'lean')
    reified = reify(env.type('Real'), env, scope)
    comparison = next(ast.literal_eval(n.value)
        for n in ast.parse((ROOT / 'tools/check_basic_targets.py').read_text()).body
        if isinstance(n, ast.Assign) and any(isinstance(t, ast.Name) and t.id == 'COMPARISON' for t in n.targets))
    native = lean(results, env, ['Lean']) + comparison + f'''
def expected_local : Prop := ∀ (Real : Type) (x : Real), x = x
same_basic_target CleanStatements.local_carrier_identity expected_local
def actual_quantified : Prop := {quantified.lean}
def expected_quantified : Prop := ∀ (A : Type) (x : A), x = x
same_basic_target actual_quantified expected_quantified
def actual_alias : Prop := ∀ (Real : Type) (x : {alias}), x = x
def expected_alias : Prop := ∀ (Real : Type) (x : ℝ), x = x
same_basic_target actual_alias expected_alias
def actual_reified (Real : Type) : Type := {reified.lean}
def expected_reified (Real : Type) : Type := ℝ
same_basic_target actual_reified expected_reified
theorem local_checked : CleanStatements.local_carrier_identity := by intro A x; rfl
theorem quantified_checked : actual_quantified := by intro A x; rfl
theorem alias_checked : actual_alias := by intro A x; rfl
'''
    output = COMPILER / 'LocalTypesVerified.lean'
    output.write_text(native)
    subprocess.run([os.environ.get('LAKE', '/home/claude/.elan/bin/lake'), 'env', 'lean', str(output)],
                   cwd=ROOT, check=True)
    (HERE / 'PrototypeVerified.lean').write_text(native)
    (HERE / 'Prototype.tex').write_text(latex(results, env))
    print('Eleven preservation checks, four exact Lean targets and three proofs passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
