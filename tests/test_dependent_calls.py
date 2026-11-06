# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Independent structural substitution and rejection cases."""
import unittest
from pathlib import Path
from cleanlang.core import Environment, Expr, Type, ValueIndex, Expressions, CleanError
from cleanlang.modules import load_module, notation, condition_declaration
from cleanlang import syntax
ROOT = Path(__file__).resolve().parents[1]

class DependentCalls(unittest.TestCase):
    def setUp(self):
        self.e = Environment()
        load_module(ROOT/'library/topology/paths.clean', self.e)
        X = Type('X')
        self.local = {'X': Expr('X','X',Type('Type')),
                      't': Expr('t','t',Type('Topology',(X,))),
                      'u': Expr('u','u',Type('Topology',(X,))),
                      'x': Expr('x','x',X), 'y': Expr('y','y',X), 'z': Expr('z','z',X)}
        for name, typ in [('p','Path(X,t,x,y)'),('q','Path(X,t,y,z)')]:
            self.local[name] = Expr(name,name,self.e.type(typ,self.local))
    def expr(self, text): return Expressions(self.e,self.local).parse(text)
    def test_parse_is_ordinary_call(self):
        self.assertEqual(syntax.expression_tree(syntax.parse('constant path(t,x)','expression')),
                         ['Call','constant path',[['Local','t'],['Local','x']]])
    def test_returns_substituted_endpoints(self):
        self.assertEqual(self.expr('reverse path(t,x,y,p)').type,
                         self.e.type('Path(X,t,y,x)',self.local))
    def test_composition_uses_intermediate_index(self):
        self.assertEqual(self.expr('join paths(t,x,y,z,p,q)').type,
                         self.e.type('Path(X,t,x,z)',self.local))
        with self.assertRaisesRegex(CleanError,'index mismatch'):
            self.expr('join paths(t,x,y,z,p,p)')
    def test_wrong_topology_rejected(self):
        with self.assertRaisesRegex(CleanError,'index mismatch'):
            self.expr('reverse path(u,x,y,p)')
    def test_reversed_endpoints_rejected(self):
        with self.assertRaisesRegex(CleanError,'index mismatch'):
            self.expr('reverse path(t,y,x,p)')
    def test_nested_calls_keep_type(self):
        self.assertEqual(self.expr('reverse path(t,y,x,reverse path(t,x,y,p))').type,self.local['p'].type)
    def test_authored_definition(self):
        self.assertEqual(self.expr('reverse twice(t,x,y,p)').type,self.local['p'].type)
        self.assertEqual(self.e.definitions['reverse twice']['implementation'],'equals')
    def test_computed_index_must_be_named(self):
        notation('Notation same point(x):',['Let X: Type','Let x: X','Returns: X',
                 'Means: x','Render latex: {x}'],self.e)
        with self.assertRaisesRegex(CleanError,'named local'):
            self.expr('constant path(t,same point(x))')
    def test_naming_computed_index_is_supported(self):
        self.local['w']=Expr('w','w',Type('X'))
        self.assertEqual(self.expr('constant path(t,w)').type,
                         self.e.type('Path(X,t,w,w)',self.local))
    def test_fresh_bound_endpoint_is_used(self):
        term=self.expr('for every (a: X, constant path(t,a) = constant path(t,a))')
        self.assertIn('(clean_bound_0)',term.lean)
        self.assertNotIn('(a)',term.lean)
    def test_fresh_bound_carrier_is_used(self):
        term=self.expr('for every (Y: Type, for every (v: Topology(Y), for every (b: Y, constant path(v,b) = constant path(v,b))))')
        self.assertIn('(clean_bound_0) (clean_bound_1) (clean_bound_2)',term.lean)
    def test_no_lambda_index_escape(self):
        with self.assertRaisesRegex(CleanError,'nondependent return'):
            self.expr('function(a: X, constant path(t,a))')
    def test_local_identity_not_just_printed_name(self):
        self.local['p'].type=Type('Path',(Type('X'),ValueIndex('t','different_t','t'),
                                       ValueIndex('x','x','x'),ValueIndex('y','y','y')))
        with self.assertRaisesRegex(CleanError,'index mismatch'):
            self.expr('reverse path(t,x,y,p)')
    def test_implicit_carrier_conflict(self):
        self.local['x'].type=Type('Real')
        with self.assertRaisesRegex(CleanError,'Inconsistent'):
            self.expr('constant path(t,x)')
    def test_condition_with_dependent_arguments(self):
        condition_declaration('Condition path equal(t,x,y,p,q):',
            ['Let X: Type','Let t: Topology(X)','Let x,y: X',
             'Let p,q: Path(X,t,x,y)','Holds when: p=q'],self.e)
        self.assertEqual(self.expr('path equal(t,x,y,p,p)').type,Type('Proposition'))
    def test_forward_dependency_is_rejected(self):
        with self.assertRaises(CleanError):
            notation('Notation bad(p,t,x):',['Let X: Type','Let p: Path(X,t,x,x)',
                'Let t: Topology(X)','Let x: X','Returns: X','Means: x','Render latex: {x}'],self.e)
    def test_argument_count(self):
        with self.assertRaisesRegex(CleanError,'number of arguments'):
            self.expr('constant path(t)')
    def test_bound_alias_preserves_own_identity(self):
        self.local['v']=Expr('v','v',self.local['t'].type)
        with self.assertRaisesRegex(CleanError,'index mismatch'):
            self.expr('reverse path(v,x,y,p)')

    def test_explicit_carrier_parameter(self):
        notation('Notation stay(X: Type, t: Topology(X), x: X): Path(X,t,x,x):',
                 ['Means: @Path.refl X t x','Render latex: {x}'],self.e)
        self.assertEqual(self.expr('stay(X,t,x)').type,self.e.type('Path(X,t,x,x)',self.local))
    def test_natural_dimension_inference(self):
        from cleanlang.modules import type_declaration
        type_declaration('Type Tagged(n: Natural, x: Vector(n,Real)):',
                         ['Means: Option (Fin n)','Render latex: tag'],self.e)
        notation('Notation tag(x):',['Let n: Natural','Let x: Vector(n,Real)',
                                    'Returns: Tagged(n,x)','Means: none','Render latex: {x}'],self.e)
        # This test checks structural natural-index inference, not adapter elaboration.
        self.local['v']=Expr('v','v',Type('Vector',('3',Type('Real'))))
        self.assertEqual(self.expr('tag(v)').type,Type('Tagged',('3',ValueIndex('v','v','v'))))
    def test_actual_local_index_does_not_capture_declared_name(self):
        self.local['a']=Expr('bound_a','a',Type('X'))
        result=self.expr('constant path(t,a)')
        self.assertEqual(result.type.args[-1],ValueIndex('a','bound_a','a'))
        self.assertIn('(bound_a)',result.lean)
    def test_declaration_field_order_does_not_change_target(self):
        fields=['Let X: Type','Let t: Topology(X)','Let x: X','Returns: Path(X,t,x,x)',
                'Means: @Path.refl X t x','Render latex: {x}']
        other=Environment();load_module(ROOT/'library/topology/paths.clean',other)
        notation('Notation ordered(t,x):',fields,self.e)
        notation('Notation ordered(t,x):',[fields[-1],*fields[:-1]],other)
        self.assertEqual(self.e.data['functions']['ordered'],other.data['functions']['ordered'])

# generated: gpt-6 2026-11-06 role=assisted; LLM-authored portions; see PROVENANCE.md
