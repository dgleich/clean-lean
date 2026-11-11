# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Retained module calls obey the same fresh-traversal rule as ordinary calls."""
from pathlib import Path
import unittest
from unittest.mock import patch
from cleanlang.core import Environment,Expr,Expressions,CleanError
from cleanlang.modules import load_module,notation,condition_declaration
from cleanlang.bound_calls import bind
from cleanlang.conversion import comparison_normal_form
ROOT=Path(__file__).resolve().parents[1]

class BoundComparisonReuse(unittest.TestCase):
    def setUp(self):
        self.env=Environment();load_module(ROOT/'library/logic/functions.clean',self.env)
        notation('Notation retain(x):',['Let A: Type','Let x: A','Returns: A',
                 'Means: x','Render latex: {x}'],self.env)
        condition_declaration('Condition equal(x,y):', ['Let T: Type','Let x,y: T',
                              'Infix: =','From Lean: x=y','Render latex: {x}={y}'],self.env)
        self.local={n:Expr(n,n,self.env.type('Type')) for n in ['A','B']}
        self.rebind('first','A')

    def rebind(self,target,typ):
        self.local['x']=Expr(target,'x',self.env.type(typ,self.local),tree=['Local','x'])

    def expression(self,depth=1):
        tree=['Local','x']
        for _ in range(depth):tree=['Call','retain',[tree]]
        tree=bind(tree,self.env,self.local)
        return Expressions(self.env,self.local).elaborate(tree)

    def test_nested_bound_checks_each_call_once(self):
        depth=12;old=self.expression(depth)
        self.rebind('second','B')
        with patch.object(self.env,'call',wraps=self.env.call) as calls:
            actual=comparison_normal_form(old,self.env,self.local)
        self.assertLessEqual(calls.call_count,depth)
        expected=self.expression(depth)
        self.assertEqual((actual.lean,actual.type,actual.tree),
                         (expected.lean,expected.type,expected.tree))

    def test_public_entry_rechecks_changed_value(self):
        old=self.expression();self.rebind('second','A')
        actual=comparison_normal_form(old,self.env,self.local)
        self.assertEqual(actual.lean,self.expression().lean)
        self.assertNotIn('first',actual.lean)

    def test_public_entry_ignores_mutated_checked_arguments(self):
        old=self.expression();old.checked_args=(Expr('bogus','bogus',self.env.type('B',self.local)),)
        self.rebind('second','B')
        actual=comparison_normal_form(old,self.env,self.local)
        expected=self.expression()
        self.assertEqual((actual.lean,actual.type),(expected.lean,expected.type))
        self.assertNotIn('bogus',actual.lean)

    def test_changed_bound_template_rejects(self):
        old=self.expression(3)
        self.env.data['functions']['retain']['lean']+=' changed'
        with self.assertRaisesRegex(CleanError,'Changed bound module callable'):
            comparison_normal_form(old,self.env,self.local)

    def test_incomplete_recheck_propagates(self):
        old=self.expression(3)
        with patch.object(self.env,'call',side_effect=TimeoutError('incomplete call')):
            with self.assertRaises(TimeoutError):comparison_normal_form(old,self.env,self.local)

    def test_fresh_reuse_still_checks_bound_identity(self):
        term=self.expression()
        original=Expressions(self.env,self.local).elaborate(['Operator','=',term.tree,term.tree])
        call=self.env.call
        def change_after_check(*args,**kwargs):
            result=call(*args,**kwargs)
            self.env.data['functions']['retain']['lean']+=' changed'
            return result
        with patch.object(self.env,'call',side_effect=change_after_check):
            with self.assertRaisesRegex(CleanError,'Changed bound module callable'):
                comparison_normal_form(original,self.env,self.local)

    def test_changed_normalized_argument_rechecks_parent(self):
        self.local['z']=Expr('z','z',self.local['x'].type,tree=['Local','z'],
                             local_normal=self.local['x'])
        tree=bind(['Call','retain',[['Call','retain',[['Local','z']]]]],self.env,self.local)
        old=Expressions(self.env,self.local).elaborate(tree)
        with patch.object(self.env,'call',wraps=self.env.call) as calls:
            actual=comparison_normal_form(old,self.env,self.local)
        self.assertEqual(calls.call_count,3)
        self.assertEqual(actual.lean,self.expression(2).lean)
        self.assertNotIn('(z)',actual.lean)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md

# generated: gpt-6 2026-11-11 role=assisted
class ProjectionBaseReuse(unittest.TestCase):
    def setUp(self):
        from cleanlang.structures import declare
        self.env=Environment();load_module(ROOT/'library/operators.clean',self.env)
        declare('Structure Box():',['Let value: Real','Constructor: box'],self.env)
        key=self.env.data['functions']['box']['native_binding']
        notation('Notation opaque box(x: Real): Box:',
                 ['Means: '+key+' x','Render latex: B({x})'],self.env)
        self.local={'x':Expr('first','x',self.env.type('Real'),tree=['Local','x'])}
        self.old=Expressions(self.env,self.local).parse('opaque box(x).value')

    def test_projection_base_checked_once_per_internal_traversal(self):
        with patch.object(self.env,'call',wraps=self.env.call) as calls:
            result=comparison_normal_form(self.old,self.env,self.local)
        checked=[c for c in calls.call_args_list if c.args[0]=='opaque box']
        self.assertEqual(len(checked),1) # Fresh source check shared within this traversal.
        self.assertEqual(result.tree,self.old.tree)
        self.assertEqual(result.lean,self.old.lean)

    def test_projection_public_entry_rechecks_changed_local(self):
        self.local['x']=Expr('second','x',self.env.type('Real'),tree=['Local','x'])
        result=comparison_normal_form(self.old,self.env,self.local)
        expected=Expressions(self.env,self.local).parse('opaque box(x).value')
        self.assertEqual((result.lean,result.type,result.tree),(expected.lean,expected.type,expected.tree))
        self.assertNotIn('first',result.lean)

    def test_projection_unavailable_base_check_propagates(self):
        with patch.object(self.env,'call',side_effect=TimeoutError('Unavailable base check')):
            with self.assertRaises(TimeoutError):comparison_normal_form(self.old,self.env,self.local)


# generated: gpt-6 2026-11-11 role=assisted
class ApplicationChildrenReuse(unittest.TestCase):
    def setUp(self):
        self.env=Environment();load_module(ROOT/'library/operators.clean',self.env)
        real=self.env.type('Real')
        self.local={'x':Expr('first','x',real,tree=['Local','x']),
                    'f':Expr('f','f',self.env.type('Function(Real,Real)'),tree=['Local','f'])}

    def application(self,depth=1):
        tree=['Local','x']
        for _ in range(depth):tree=['Apply',['Local','f'],[tree]]
        return Expressions(self.env,self.local).elaborate(tree)

    def test_nested_application_checks_leaf_once(self):
        old=self.application(12);original=Expressions._elaborate;leaves=[]
        def counted(worker,tree):
            if tree==['Local','x']:leaves.append(tree)
            return original(worker,tree)
        with patch.object(Expressions,'_elaborate',counted):
            result=comparison_normal_form(old,self.env,self.local)
        self.assertEqual(len(leaves),1)
        self.assertEqual((result.lean,result.type,result.tree),(old.lean,old.type,old.tree))

    def test_public_application_ignores_saved_children_and_rechecks_scope(self):
        old=self.application(2)
        old.checked_args=(Expr('bogus','bogus',self.local['f'].type),self.local['x'])
        self.local['x']=Expr('second','x',self.env.type('Real'),tree=['Local','x'])
        result=comparison_normal_form(old,self.env,self.local)
        expected=self.application(2)
        self.assertEqual((result.lean,result.type,result.tree),(expected.lean,expected.type,expected.tree))
        self.assertNotIn('bogus',result.lean)

    def test_public_application_rejects_changed_argument_type(self):
        old=self.application()
        self.local['x']=Expr('wrong','x',self.env.type('Complex'),tree=['Local','x'])
        with self.assertRaises(CleanError):comparison_normal_form(old,self.env,self.local)

    def test_application_unavailable_check_propagates(self):
        old=self.application()
        with patch.object(Expressions,'elaborate',side_effect=TimeoutError('Unavailable application')):
            with self.assertRaises(TimeoutError):comparison_normal_form(old,self.env,self.local)


# generated: gpt-6 2026-11-11 role=assisted
class NestedProjectionReuse(unittest.TestCase):
    def setUp(self):
        from cleanlang.structures import declare
        self.env=Environment();load_module(ROOT/'library/operators.clean',self.env)
        declare('Structure Cell(A: Type):',['Let value: A','Constructor: cell'],self.env)
        self.local={}

    def projection(self,depth=12,carrier='Real',target='first'):
        typ=carrier
        for _ in range(depth):typ='Cell('+typ+')'
        self.local['b']=Expr(target,'b',self.env.type(typ),tree=['Local','b'])
        tree=['Local','b']
        for _ in range(depth):tree=['Projection',tree,'value']
        return Expressions(self.env,self.local).elaborate(tree)

    def test_nested_projection_checks_base_once(self):
        old=self.projection();original=Expressions._elaborate;leaves=[]
        def counted(worker,tree):
            if tree==['Local','b']:leaves.append(tree)
            return original(worker,tree)
        with patch.object(Expressions,'_elaborate',counted):
            actual=comparison_normal_form(old,self.env,self.local)
        self.assertEqual(len(leaves),1)
        self.assertEqual((actual.lean,actual.type,actual.tree),(old.lean,old.type,old.tree))

    def test_public_projection_ignores_saved_base_and_rechecks_type(self):
        old=self.projection(3)
        old.checked_args=(Expr('bogus','bogus',self.env.type('Real')),)
        expected=self.projection(3,'Complex','second')
        actual=comparison_normal_form(old,self.env,self.local)
        self.assertEqual((actual.lean,actual.type,actual.tree),(expected.lean,expected.type,expected.tree))
        self.assertNotIn('bogus',actual.lean)

    def test_public_projection_rejects_missing_field(self):
        old=self.projection(3)
        self.local['b']=Expr('other','other',self.env.type('Real'),tree=['Local','b'])
        with self.assertRaises(CleanError):comparison_normal_form(old,self.env,self.local)

    def test_projection_recheck_failure_propagates(self):
        old=self.projection(3)
        with patch.object(Expressions,'elaborate',side_effect=TimeoutError('Unavailable projection')):
            with self.assertRaises(TimeoutError):comparison_normal_form(old,self.env,self.local)
