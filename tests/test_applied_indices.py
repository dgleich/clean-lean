# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
import json,unittest
from pathlib import Path
from cleanlang.core import Environment, Expr, Expressions, CleanError
from cleanlang.modules import load_module, load_document
from cleanlang.indices import index_value
from cleanlang import syntax
ROOT=Path(__file__).resolve().parents[1]

class AppliedIndices(unittest.TestCase):
    def setUp(self):
        self.e=Environment();load_module(ROOT/'library/topology/pair_composition.clean',self.e)
        self.local={}
        for n,t in [('a','Real'),('b','Real'),('z','Complex'),('hab','Evidence((a=b))'),
                    ('f','Function(Real,Real)'),('g','Function(Real,Real)'),('hfg','Evidence((f=g))'),
                    ('X','TopologicalSpace'),('P','TopologicalPair(X)'),('Q','TopologicalPair(X)'),
                    ('hpq','Evidence((P=Q))')]:
            self.local[n]=Expr(n,n,self.e.type(t,self.local))
    def expr(self,s):return Expressions(self.e,self.local).parse(s)
    def test_unique_source_tree(self):
        self.assertEqual(syntax.expression_tree(syntax.parse('function(t: Real,t+a)','expression')),
          ['Lambda','t','Real',['Operator','+',['Local','t'],['Local','a']]])
    def test_congruence_preserves_lambda_argument(self):
        proof=self.expr('equality congruence(function(t: Real,t+a),a,b,hab)')
        self.assertEqual(proof.type,self.e.type('Evidence((a+a=b+a))',self.local))
        self.assertEqual(proof.tree[2][0],['Lambda','t','Real',['Operator','+',['Local','t'],['Local','a']]])
        self.assertIn('fun (clean_bound_',proof.lean)
        self.assertNotIn('clean_bound_',proof.type.args[0].lean)
    def test_projected_result(self):
        proof=self.expr('equality congruence(function(t: TopologicalPair(X),t.ambient),P,Q,hpq)')
        self.assertEqual(proof.type,self.e.type('Evidence((P.ambient=Q.ambient))',self.local))
    def test_function_valued_binder(self):
        proof=self.expr('equality congruence(function(t: Function(Real,Real),t(a)),f,g,hfg)')
        self.assertEqual(proof.type,self.e.type('Evidence((f(a)=g(a)))',self.local))
    def test_unused_argument_still_checked(self):
        with self.assertRaises(CleanError):
            self.expr('equality congruence(function(t: Real,a),z,z,equality reflexivity(z))')
        tree=['Apply',['Lambda','t','Real',['Local','a']],[['Local','z']]]
        with self.assertRaises(CleanError):Expressions(self.e,self.local).elaborate(tree)
    def test_no_capture_or_shadowing(self):
        with self.assertRaisesRegex(CleanError,'fresh'):
            self.expr('equality congruence(function(a: Real,a),a,b,hab)')
    def test_bare_lambda_remains_rejected(self):
        with self.assertRaisesRegex(CleanError,'do not introduce binders'):
            index_value(self.expr('function(t: Real,t)'),self.e,self.local)
    def assert_preserved_application(self,body,binder,operation,symbol):
        value=self.expr('equality congruence(function(t: Real,'+body+'),a,b,hab)')
        from cleanlang.retained_codec import loads
        tree=loads(value.type.args[0].syntax)
        # Independently specify both the retained identity-bearing tree and its
        # source projection. Printed source cannot encode declaration identities.
        def branch(offset,argument,bound):
            t='clean_conversion_bound_'+str(offset)
            u='clean_conversion_bound_'+str(offset+1)
            operands=[['Local',t],['Local',u]]
            inner=(['ModuleCall',operation,operands,
                    self.e.data['functions'][operation]['lean'],['infix',symbol]]
                   if bound else ['Operator',symbol,*operands])
            from cleanlang.annotations import Annotation
            annotation=Annotation('Real',self.e.type('Real')) if bound else 'Real'
            return ['Apply',['Lambda',t,annotation,[binder,u,annotation,inner]],[['Local',argument]]]
        expected=['ModuleCall','equal',[branch(0,'a',True),branch(2,'b',True)],
                  self.e.data['functions']['equal']['lean'],['infix','=']]
        self.assertEqual(tree,expected)
        self.assertEqual(syntax.expression_tree(syntax.parse(syntax.condition_spelling(tree),'expression')),
                         ['Operator','=',branch(0,'a',False),branch(2,'b',False)])
    def test_quantified_body_application_is_preserved(self):
        self.assert_preserved_application('for every (u: Real,t=u)','Forall','equal','=')
    def test_nested_lambda_application_is_preserved(self):
        self.assert_preserved_application('function(u: Real,t+u)','Lambda','real sum','+')
    def test_named_function_stays_opaque(self):
        proof=self.expr('equality congruence(f,a,b,hab)')
        self.assertEqual(proof.type,self.e.type('Evidence((f(a)=f(b)))',self.local))
    def test_beta_contraction_preserves_inferred_numeral_carrier(self):
        tree=['Apply',['Lambda','t','Real',['Local','t']],[['Decimal','1']]]
        expression=Expressions(self.e,self.local).elaborate(tree)
        value=index_value(expression,self.e,self.local)
        spec=self.e.data['types']['Real'];attachment=spec['numerals']
        identity=[spec['native_binding'],spec['native_declaration'],spec['native_template'],
                  attachment['native_binding'],attachment['native_declaration'],attachment['payload']]
        expected=['BoundNumeral','1','Real',identity,'inferred']
        self.assertEqual(value.resolved,expected)
        from cleanlang.retained_codec import loads
        self.assertEqual(loads(value.syntax),expected)
        target='(_root_.'+attachment['native_binding']+' (nat_lit 1))'
        self.assertEqual(value.lean,target)
        self.assertEqual(value.comparison,target)
        self.assertEqual(Expressions(self.e,self.local).elaborate(value.resolved).type,
                         self.e.type('Real'))
    def test_pair_composition_authored(self):
        for name in ['pair ambient equality','pair relative equality','identity pair inclusion','compose pair inclusions']:
            self.assertEqual(self.e.definitions[name]['implementation'],'equals')
        e=Environment()
        self.assertEqual(len(load_document(ROOT/'studies/topology/PairComposition.clean',e)),6)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
