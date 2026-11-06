# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
import unittest
from pathlib import Path
from cleanlang.core import Environment,Expr,Type,Expressions,CleanError,lean
from cleanlang.modules import load_module,load_document
ROOT=Path(__file__).resolve().parents[1]
class InterlevelInterfaces(unittest.TestCase):
    def setUp(self):
        self.e=Environment();load_module(ROOT/'library/topology/interlevel.clean',self.e)
        self.local={}
        for n,t in [('X','TopologicalSpace'),('Y','TopologicalSpace'),('f','ContinuousRealMap(X)'),
                    ('I','Endpoints'),('E','EndpointSelection'),('P','InterlevelProblem'),('r','Real')]:
            self.local[n]=Expr(n,n,self.e.type(t,self.local))
    def expr(self,s):return Expressions(self.e,self.local).parse(s)
    def test_four_choices_are_authored(self):
        for name in ['no endpoints','lower endpoint','upper endpoint','both endpoints']:
            self.assertEqual(self.e.definitions[name]['implementation'],'equals')
            self.assertEqual(self.expr(name+'()').type,Type('EndpointSelection'))
    def test_real_map_keeps_source_space(self):
        with self.assertRaisesRegex(CleanError,'index mismatch'):
            self.expr('underlying real map(Y,f)')
    def test_problem_constructor_checks_dependent_field(self):
        self.assertEqual(self.expr('interlevel problem(X,f,I,E)').type,Type('InterlevelProblem'))
        with self.assertRaisesRegex(CleanError,'index mismatch'):
            self.expr('interlevel problem(Y,f,I,E)')
    def test_pairs_have_same_ambient_index(self):
        expected=self.e.type('SpacePairData(P.space)',self.local)
        for name in ['expanded pair','shifted pair']:
            self.assertEqual(self.expr(name+'(P,r)').type,expected)
            self.assertEqual(self.e.definitions[name]['implementation'],'equals')
    def test_different_problem_spaces_do_not_merge(self):
        self.local['Q']=Expr('Q','Q',Type('InterlevelProblem'))
        with self.assertRaisesRegex(CleanError,'index mismatch'):
            self.expr('pair included in(P.space,shifted pair(P,r),expanded pair(Q,r))')
    def test_pair_data_does_not_assert_nesting(self):
        fields=self.e.structures['SpacePairData']['fields']
        self.assertEqual([n for n,_ in fields],['ambient','relative'])
        self.assertIn('nested pair',self.e.definitions)
    def test_boolean_module_is_shared_with_common(self):
        e=Environment();load_module(ROOT/'library/Common.clean',e)
        load_module(ROOT/'library/logic/booleans.clean',e)
        self.assertEqual(e.data['types']['Boolean'],self.e.data['types']['Boolean'])
    def test_study_statements_translate(self):
        e=Environment();r=load_document(ROOT/'studies/topology/Interlevel.clean',e)
        self.assertEqual(len(r),12)
        target=lean(r,e,[])
        self.assertNotIn('CleanPapers',target)
        self.assertNotIn('sorry',target)

    def test_perturbation_keeps_its_source_space(self):
        self.local['h']=Expr('h','h',self.e.type('ContinuousRealMap(P.space)',self.local))
        self.assertEqual(self.expr('perturbed pair(P,h)').type,self.e.type('SpacePairData(P.space)',self.local))
        with self.assertRaisesRegex(CleanError,'index mismatch'):
            self.expr('bounded perturbation(P,f,r)')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md

    def test_certification_requires_the_actual_nesting_proof(self):
        load_module(ROOT/'library/topology/certified_interlevel.clean',self.e)
        self.local['Q']=Expr('Q','Q',self.e.type('SpacePairData(X)',self.local))
        self.local['h']=Expr('h','h',self.e.type('(Q.relative ⊆ Q.ambient)',self.local))
        self.assertEqual(self.expr('certify pair data(X,Q,h)').type,
                         self.e.type('TopologicalPair(X)',self.local))
        self.local['wrong']=Expr('wrong','wrong',self.e.type('(Q.ambient ⊆ Q.relative)',self.local))
        with self.assertRaises(CleanError):self.expr('certify pair data(X,Q,wrong)')
        with self.assertRaises(CleanError):self.expr('certify pair data(Y,Q,h)')

    def test_composed_certificate_checks_each_proof(self):
        load_module(ROOT/'library/topology/certified_interlevel.clean',self.e)
        for n,t in [('S','SpacePairData(X)'),('T','SpacePairData(X)'),
                    ('s','(S.relative ⊆ S.ambient)'),('t','(T.relative ⊆ T.ambient)'),
                    ('a','(S.ambient ⊆ T.ambient)'),('b','(S.relative ⊆ T.relative)')]:
            self.local[n]=Expr(n,n,self.e.type(t,self.local))
        self.assertEqual(self.expr('certify pair inclusion(X,S,T,s,t,a,b)').type,
                         self.e.type('PairInclusion(X)',self.local))
        self.assertEqual(self.expr('certify pair inclusion(X,S,T,s,t,a,b).source.ambient').lean,
                         self.expr('S.ambient').lean)
        with self.assertRaises(CleanError):self.expr('certify pair inclusion(X,S,T,s,t,b,a)')
