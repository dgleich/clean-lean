# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from cleanlang.core import Environment,Expr,Expressions,CleanError,ValueIndex
from cleanlang.modules import load_module,notation
from cleanlang.conversion import comparison_normal_form
ROOT=Path(__file__).resolve().parents[1]
class DefinitionConversion(unittest.TestCase):
    def setUp(self):
        self.e=Environment();load_module(ROOT/'library/topology/relative_maps.clean',self.e)
        load_module(ROOT/'library/topology/interlevel.clean',self.e)
        self.local={}
        for n,t in [('K','Type'),('field','FieldStructure(K)'),('H','HomologyTheory(K,field)'),
                    ('X','TopologicalSpace'),('Y','TopologicalSpace'),('P','TopologicalPair(X)'),
                    ('Q','PairInclusion(X)'),('C','ModuleChainComplex(K,field)'),('D','ModuleChainComplex(K,field)'),
                    ('I','Endpoints'),('a','Real'),('b','Real')]:
            self.local[n]=Expr(n,n,self.e.type(t,self.local))
    def expr(self,s):return Expressions(self.e,self.local).parse(s)
    def norm(self,s):return comparison_normal_form(self.expr(s),self.e,self.local)
    def test_relative_chain_index_matches_expansion(self):
        named=self.e.type('ChainMap(K,field,C,(relative chains(field,H,X,P)))',self.local)
        expanded=self.e.type('ChainMap(K,field,C,(chain cokernel(field,singular chains(field,H,subspace(X,P.relative)),singular chains(field,H,subspace(X,P.ambient)),pair chain inclusion(field,H,X,P))))',self.local)
        self.assertEqual(named,expanded)
        self.assertNotEqual(self.e.render_type(named,'lean'),self.e.render_type(expanded,'lean'))
    def test_raw_terms_are_preserved(self):
        value=self.expr('relative chains(field,H,X,P)')
        self.assertIn('relative_chains',value.lean)
        self.assertNotIn('relative_chains',self.norm('relative chains(field,H,X,P)').lean)
    def test_named_local_is_still_opaque(self):
        t=self.expr('relative chains(field,H,X,P)').type
        self.local['R']=Expr('R','R',t)
        self.assertNotEqual(self.e.type('ChainMap(K,field,C,R)',self.local),
                            self.e.type('ChainMap(K,field,C,(relative chains(field,H,X,P)))',self.local))
    def test_comparison_and_hash_agree(self):
        from cleanlang.indices import index_value
        a=index_value(self.expr('relative chains(field,H,X,P)'),self.e,self.local)
        b=index_value(self.expr('chain cokernel(field,singular chains(field,H,subspace(X,P.relative)),singular chains(field,H,subspace(X,P.ambient)),pair chain inclusion(field,H,X,P))'),self.e,self.local)
        self.assertEqual(a,b);self.assertEqual(hash(a),hash(b))
    def test_condition_evidence_converts_but_is_not_proved(self):
        p=self.e.type('(pair chain commutes(field,H,X,Q))',self.local)
        self.local['h']=Expr('h','h',p)
        result=self.expr('relative chain map(field,H,X,Q,h)')
        self.assertIn('(h)',result.lean)
        with self.assertRaises(CleanError):self.expr('relative chain map(field,H,X,Q)')
    def test_wrong_pair_evidence_is_rejected(self):
        self.local['R']=Expr('R','R',self.local['Q'].type)
        self.local['h']=Expr('h','h',self.e.type('(pair chain commutes(field,H,X,R))',self.local))
        with self.assertRaises(CleanError):self.expr('relative chain map(field,H,X,Q,h)')
    def test_native_adapter_is_opaque(self):
        notation('Notation native endpoints(I: Endpoints): Endpoints:',
                 ['Means: I','Render latex: {I}'],self.e)
        self.assertIn('native_endpoints',self.norm('native endpoints(I)').lean)
    def test_numeric_placeholder_stays_opaque(self):
        notation('Define zero real(): Real:',['Equals: 0'],self.e,authored=True)
        self.assertIn('zero_real',self.norm('zero real()').lean)
    def test_unused_implicit_parameters_do_not_block(self):
        # K is inferred from field; it does not occur as an expression in the body.
        notation('Define retain complex(field,C):',['Let K: Type','Let field: FieldStructure(K)',
          'Let C: ModuleChainComplex(K,field)','Returns: ModuleChainComplex(K,field)','Equals: C'],self.e,authored=True)
        self.assertEqual(self.norm('retain complex(field,C)').lean,'C')
    def test_inferred_certificate_expands_and_binder_body_stays_opaque(self):
        self.local['S']=Expr('S','S',self.e.type('Set(K)',self.local))
        self.local['T']=Expr('T','T',self.e.type('Set(K)',self.local))
        self.local['h']=Expr('h','h',self.e.type('(S ⊆ T)',self.local))
        self.assertIn('subset_certificate',self.expr('subset certificate(S,T,h)').lean)
        expanded=self.norm('subset certificate(S,T,h)')
        selected=self.e.data['functions']['certified inclusion']['lean']
        self.assertEqual(expanded.tree,['ModuleCall','certified inclusion',
                         [['Local',n] for n in ['K','S','T','h']],selected])
        self.assertEqual(expanded.lean,self.expr('certified inclusion(K,S,T,h)').lean)
        self.assertIn('closed_interval',self.norm('closed interval(I)').lean)
    def test_no_algebraic_rewriting(self):
        self.assertNotEqual(self.norm('a+b').lean,self.norm('b+a').lean)
    def test_source_projection_reduction_is_unchanged(self):
        self.assertEqual(self.expr('endpoints(a,b).lower').lean,'a')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
    def test_function_formal_keeps_call_resolution(self):
        notation('Define apply scalar(f: Function(Real,Real),x: Real): Real:',
                 ['Equals: f(x)'],self.e,authored=True)
        self.local['g']=Expr('g','g',self.e.type('Function(Real,Real)'))
        self.assertEqual(self.norm('apply scalar(g,a)').lean,self.expr('g(a)').lean)
    def test_substitution_is_simultaneous(self):
        notation('Define second scalar(a: Real,b: Real): Real:',['Equals: b'],self.e,authored=True)
        self.assertEqual(self.norm('second scalar(b,a)').lean,'a')
    def test_comparison_projection_can_expose_a_constructor(self):
        notation('Define retain endpoints(x,I):',
          ['Let X: Type','Let x: X','Let I: Endpoints','Returns: Endpoints','Equals: I'],self.e,authored=True)
        original=self.expr('retain endpoints(a,I).lower')
        self.assertIn('retain_endpoints',original.lean)
        self.assertEqual(self.norm('retain endpoints(a,I).lower').lean,self.expr('I.lower').lean)
