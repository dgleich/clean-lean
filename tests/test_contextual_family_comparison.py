# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Regression: authored function aliases beneath an opaque native application.

The positive equivalence and hash assertions currently fail. Do not weaken them or
remove the dependent-index hidden-binder guard just to satisfy this specimen.
"""
from pathlib import Path
import tempfile,unittest
from cleanlang.core import Environment,Expr
from cleanlang.modules import load_module
ROOT=Path(__file__).resolve().parents[1]
SOURCE='''Notation sample(f: Function(Real,Real)): Real:
  Means: f 0
  Render latex: sample({f})
Define constant(x: Real): Function(Real,Real):
  Equals: function(y: Real,x)
Define sampled(x: Real): Real:
  Equals: sample(constant(x))
'''

class ContextualFamilyComparison(unittest.TestCase):
    def setUp(self):
        self.env=Environment()
        with tempfile.TemporaryDirectory() as directory:
            path=Path(directory)/'Example.clean'
            path.write_text('Import "'+str(ROOT/'library/operators.clean')+'"\n'+
                'Import "'+str(ROOT/'library/logic/evidence.clean')+'"\n'+SOURCE)
            load_module(path,self.env)
        self.scope={n:Expr(n,n,self.env.type('Real'),tree=['Local',n]) for n in ['a','b']}
    def proof(self,condition):
        return self.env.type('Evidence(('+condition+'))',self.scope)
    def test_named_function_argument_matches_explicit_function(self):
        self.assertEqual(self.proof('sample(constant(a)) = a'),
                         self.proof('sample(function(z: Real,a)) = a'))
    def test_outer_authored_definition_matches_explicit_function(self):
        self.assertEqual(self.proof('sampled(a) = a'),
                         self.proof('sample(function(z: Real,a)) = a'))
    def test_equivalence_hashes_agree(self):
        named=self.proof('sampled(a) = a')
        explicit=self.proof('sample(function(z: Real,a)) = a')
        self.assertEqual(hash(named),hash(explicit))
    def test_sibling_expansions_keep_free_arguments(self):
        named=self.proof('sampled(a) + sampled(b) = a')
        explicit=self.proof('sample(function(x: Real,a)) + sample(function(y: Real,b)) = a')
        swapped=self.proof('sample(function(x: Real,b)) + sample(function(y: Real,a)) = a')
        self.assertEqual(named,explicit)
        self.assertNotEqual(named,swapped)
    def test_free_variables_stay_distinct(self):
        self.assertNotEqual(self.proof('sampled(a) = a'),self.proof('sampled(b) = a'))
    def test_emission_preserves_authored_calls(self):
        named=self.proof('sampled(a) = a').args[0].lean
        explicit=self.proof('sample(function(z: Real,a)) = a').args[0].lean
        self.assertIn(self.env.data['functions']['sampled']['native_binding'],named)
        self.assertNotIn('fun ',named)
        self.assertIn('fun ',explicit)
        self.assertNotEqual(named,explicit)

if __name__=='__main__':unittest.main()

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
