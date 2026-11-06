# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from cleanlang.core import Environment,Expr,Expressions,Type,CleanError
from cleanlang.modules import load_module,notation
from cleanlang.structures import declare
from cleanlang.indices import index_value
ROOT=Path(__file__).resolve().parents[1]

class FamilyComparison(unittest.TestCase):
    def setUp(self):
        self.e=Environment();load_module(ROOT/'library/types.clean',self.e)
        declare('Structure Family():',['Let component: Function(Natural,Natural)',
                                      'Constructor: family'],self.e)
        for name,binder in [('first','p'),('second','q')]:
            notation('Define '+name+'(n: Natural): Family:',
                ['Equals: family(function('+binder+': Natural,'+binder+' + n))'],self.e,authored=True)
        notation('Define renamed(n: Natural): Family:', ['Equals: first(n)'],self.e,authored=True)
        notation('Define different(n: Natural): Family:',
            ['Equals: family(function(p: Natural,n + p))'],self.e,authored=True)
        self.local={n:Expr(n,n,Type('Natural')) for n in ['n','m']}
    def expr(self,s):return Expressions(self.e,self.local).parse(s)
    def index(self,s):return index_value(self.expr(s),self.e,self.local)
    def test_alias_and_alpha_binders(self):
        a,b,c=[self.index(s) for s in ['first(n)','second(n)','renamed(n)']]
        self.assertEqual(a,b);self.assertEqual(b,c)
        self.assertEqual(hash(a),hash(c))
        self.assertIn('fun (clean_bound_0',a.comparison_key())
        self.assertIn('cleanDefine_renamed',c.lean)
    def test_bound_free_and_argument_differences(self):
        self.assertNotEqual(self.index('first(n)'),self.index('different(n)'))
        self.assertNotEqual(self.index('first(n)'),self.index('first(m)'))
    def test_caller_compiler_names_remain_free(self):
        self.local['clean_bound_0']=Expr('clean_bound_0','a',Type('Natural'))
        a=self.index('first(clean_bound_0)')
        self.assertIn('fun (clean_bound_1',a.comparison_key())
        self.assertEqual(a,self.index('second(clean_bound_0)'))
    def test_direct_binder_index_still_rejected(self):
        with self.assertRaisesRegex(CleanError,'do not introduce binders'):
            self.index('family(function(p: Natural,p + n))')
    def test_shadowed_global_stays_opaque(self):
        self.local['first']=Expr('shadow','shadow',self.e.type('Function(Natural,Family)'))
        a=self.index('renamed(n)')
        self.assertEqual(a.comparison_key(),self.expr('renamed(n)').lean)
    def test_native_body_is_opaque(self):
        notation('Notation native(n: Natural): Family:',
            ['Means: '+self.e.structures['Family']['key']+'.mk (fun p => p + n)','Render latex: N({n})'],self.e)
        self.assertNotEqual(self.index('first(n)'),self.index('native(n)'))

class RelativeGraded(unittest.TestCase):
    def test_authored_relative_map(self):
        e=Environment();load_module(ROOT/'library/topology/graded_relative_homology.clean',e)
        for name in ['graded chain homology','graded chain homology map',
                     'graded relative homology','graded relative homology map']:
            self.assertEqual(e.definitions[name]['implementation'],'equals')

class NestedFamilies(unittest.TestCase):
    def setUp(self):
        self.e=Environment();load_module(ROOT/'library/types.clean',self.e)
        declare('Structure Nested():',[
            'Let component: Function(Natural,Function(Natural,Natural))',
            'Constructor: nested'],self.e)
        for name,x,y,body in [('left','a','b','a'),('alpha','x','y','x'),('right','a','b','b')]:
            notation('Define '+name+'(): Nested:',[
                'Equals: nested(function('+x+': Natural,function('+y+': Natural,'+body+')))'],
                self.e,authored=True)
    def key(self,s):
        return index_value(Expressions(self.e,{}).parse(s),self.e,{})
    def test_nested_scope_is_preserved(self):
        self.assertEqual(self.key('left()'),self.key('alpha()'))
        self.assertNotEqual(self.key('left()'),self.key('right()'))
    def test_dependent_domains_alpha(self):
        declare('Structure Sized():',[
            'Let component: Function(n: Natural,Function(Vector(n,Real),Vector(n,Real)))',
            'Constructor: sized'],self.e)
        for name,n,v in [('sized first','n','v'),('sized second','m','w')]:
            notation('Define '+name+'(): Sized:',[
                'Equals: sized(function('+n+': Natural,function('+v+': Vector('+n+',Real),'+v+')))'],
                self.e,authored=True)
        self.assertEqual(self.key('sized first()'),self.key('sized second()'))

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
