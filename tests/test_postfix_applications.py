# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
import tempfile,unittest
from pathlib import Path
from cleanlang.core import Environment,Expr,Expressions,CleanError
from cleanlang.modules import load_module
from cleanlang.syntax import parse,expression_tree,condition_spelling,expression_spelling
ROOT=Path(__file__).resolve().parents[1]
class PostfixApplications(unittest.TestCase):
    def tree(self,s):return expression_tree(parse(s,'expression'))
    def test_left_fold_and_grouping(self):
        expected=['Apply',['Call','f',[['Local','x']]],[['Local','y']]]
        for s in ['f(x)(y)','(f(x))(y)','((f))(x)(y)']:self.assertEqual(self.tree(s),expected)
    def test_interleaved_fields(self):
        self.assertEqual(self.tree('p.make(x).value(y)'),['Apply',['Projection',['Apply',['Projection',['Local','p'],'make'],[['Local','x']]],'value'],[['Local','y']]])
    def test_multiword_call(self):
        self.assertEqual(self.tree('make map(x)(y)'),['Apply',['Call','make map',[['Local','x']]],[['Local','y']]])
        for s in ['make map','make map.field','(make map)(x)']:
            with self.assertRaises(CleanError):self.tree(s)
    def test_precedence(self):
        self.assertEqual(self.tree('-f(x)(y)^2'),['Unary','-',['Operator','^',['Apply',['Call','f',[['Local','x']]],[['Local','y']]],['Decimal','2']]])
    def test_condition_and_index_spelling(self):
        for s in ['f(x)(y)','p.make(x).value(y)','make map(x)(y)']:
            t=self.tree(s)
            for spelling in [condition_spelling,expression_spelling]:self.assertEqual(self.tree(spelling(t)),t)
        t=self.tree('(function(x: Natural,x))(n)')
        self.assertEqual(self.tree(condition_spelling(t)),t)
        with self.assertRaises(CleanError):expression_spelling(t)
    @classmethod
    def setUpClass(cls):
        cls.e=Environment();load_module(ROOT/'library/logic/evidence.clean',cls.e)
        load_module(ROOT/'library/operators.clean',cls.e)
    def locals(self,items):
        result={}
        for n,t in items:result[n]=Expr(n,n,self.e.type(t,result),tree=['Local',n])
        return result
    def test_curried_local(self):
        local=self.locals([('f','Function(Natural,Function(Natural,Natural))'),('n','Natural'),('m','Natural')])
        x=Expressions(self.e,local).parse('f(n)(m)');self.assertEqual(x.lean,'((f n) m)')
    def test_dependent_proof_result(self):
        local=self.locals([('h','Function(x: Natural,Function(Evidence((x = x)),Evidence((x = x))))'),('n','Natural'),('p','Evidence((n = n))')])
        x=Expressions(self.e,local).parse('h(n)(p)');self.assertEqual(x.lean,'((h n) p)')
        self.assertEqual(x.type,local['p'].type)
    def test_wrong_suffix_arity_or_domain(self):
        local=self.locals([('f','Function(Natural,Function(Natural,Natural))'),('n','Natural'),('z','Complex')])
        for s in ['f(n)()','f(n)(n,n)','f(n)(z)','n(n)(n)']:
            with self.assertRaises(CleanError):Expressions(self.e,local).parse(s)
    def test_lambda_target_and_rendering(self):
        local=self.locals([('n','Natural')]);value=Expressions(self.e,local).parse('(function(x: Natural,x))(n)')
        self.assertIn('fun ',value.lean);self.assertEqual(value.tex,r'\left(x \mapsto x\right)(n)')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
