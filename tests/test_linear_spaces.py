# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Distinct scalar/module structures remain distinct in explicit algebra wrappers."""
import unittest
from pathlib import Path
from cleanlang.core import Environment,Type,Expr,Expressions,CleanError,lean,latex
from cleanlang.modules import load_module,load_document
ROOT=Path(__file__).resolve().parents[1]
class LinearSpaces(unittest.TestCase):
    def setUp(self):
        self.e=Environment();load_module(ROOT/'library/algebra/linear_spaces.clean',self.e)
        self.local={n:Expr(n,n,Type('Type')) for n in ['K','V','I']}
        for n,t in [('f','FieldStructure(K)'),('g','FieldStructure(K)'),
                    ('L','LinearSpace(K,f,V)'),('M','LinearSpace(K,f,V)'),
                    ('N','LinearSpace(K,g,V)'),('U','Subspace(K,f,V,L)'),
                    ('W','Subspace(K,f,V,M)'),('x','V'),('A','Set(I)'),
                    ('spaces','Function(I,Subspace(K,f,V,L))')]:
            self.local[n]=Expr(n,n,self.e.type(t,self.local))
    def expr(self,s):return Expressions(self.e,self.local).parse(s)
    def test_real_submodule_type(self):
        target=self.e.render_type(self.local['U'].type,'lean')
        self.assertEqual(target,'@Submodule K V f.toSemiring L.addition.toAddCommMonoid L.action')
    def test_carrier_has_vector_type(self):
        self.assertEqual(self.expr('subspace carrier(f,L,U)').type,Type('Set',(Type('V'),)))
    def test_different_module_bundle_is_rejected(self):
        with self.assertRaisesRegex(CleanError,'index mismatch'):
            self.expr('subspace carrier(f,M,U)')
    def test_different_scalar_structure_is_rejected(self):
        with self.assertRaisesRegex(CleanError,'index mismatch'):
            self.expr('subspace carrier(g,L,U)')
    def test_mixed_ambient_subspaces_are_rejected(self):
        with self.assertRaisesRegex(CleanError,'index mismatch'):
            self.expr('subspace included in(f,L,U,W)')
    def test_intersection_retains_ambient_type(self):
        self.assertEqual(self.expr('intersection of subspaces(f,L,A,spaces)').type,self.local['U'].type)
    def test_wrong_index_set_rejected(self):
        self.local['B']=Expr('B','B',Type('Set',(Type('V'),)))
        with self.assertRaisesRegex(CleanError,'Inconsistent'):
            self.expr('intersection of subspaces(f,L,B,spaces)')
    def test_intersection_is_authored_not_an_adapter(self):
        self.assertEqual(self.e.definitions['intersection of subspaces']['implementation'],'equals')
        self.assertEqual(self.e.definitions['belongs to subspace']['implementation'],'equals')
        self.assertEqual(self.e.definitions['subspace included in']['implementation'],'equals')
    def test_infimum_instances_are_explicit(self):
        s=self.e.data['functions']['subspace infimum']['dependent_signature']
        target=self.e.notation_definitions[s['key']]
        self.assertIn('@Submodule.instInfSet K V f.toSemiring L.addition.toAddCommMonoid L.action',target)
    def test_study_and_rendering(self):
        e=Environment();r=load_document(ROOT/'studies/topology/Subspaces.clean',e)
        self.assertEqual(len(r),4)
        self.assertIn('indexed_intersection_membership',lean(r,e,[]))
        self.assertIn('indexed subspaces',latex(r,e))

# generated: gpt-6 2026-11-06 role=assisted; LLM-authored portions; see PROVENANCE.md
