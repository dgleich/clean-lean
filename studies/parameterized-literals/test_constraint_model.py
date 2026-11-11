# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Independent symbolic row oracles; not production Clean acceptance tests."""
import unittest
from constraint_model import Variable as V,Atom as A,Carrier as C,Row,select,select_with_trace,unify,Deferred,saturate
from constraint_model import NoSolution,Underdetermined,Ambiguous,Incomplete
NAT=C('Nat');REAL=C('Real');COMPLEX=C('Complex')
N=A('caller/n','index');M=A('caller/m','index')
def vector(n):return C('Vector',(n,COMPLEX))
def vector_row(equations=(),name='vector-zero'):
 n=V('literal/n','index')
 return Row((name,),(vector(n),),(n,),tuple(equations))

class DeferredConstraints(unittest.TestCase):
    def test_ground_forward_value_determines_dependent_dimension(self):
        output=V('successor/result','index');two=A('2','index');three=A('3','index')
        row=Row(('constructor',),(vector(output),),(output,),(),
                (Deferred(output,(two,),lambda args: three if args==(two,) else M),))
        self.assertEqual(select([row]),(('constructor',),(three,)))
    def test_chain_is_independent_of_obligation_order(self):
        x,y=V('x','index'),V('y','index')
        first=Deferred(x,(N,),lambda args:M)
        second=Deferred(y,(x,),lambda args:A('after/'+args[0].identity,'index'))
        for obligations in [(first,second),(second,first)]:
            row=Row(('chain',),(),(y,),(),obligations)
            self.assertEqual(select([row]),(('chain',),(A('after/caller/m','index'),)))
    def test_outputs_are_checked_against_existing_equations(self):
        x=V('x','index')
        row=Row(('mismatch',),(),(x,),((x,N),),(Deferred(x,(),lambda args:M),))
        with self.assertRaises(NoSolution):select([row])
    def test_no_inverse_function_inference(self):
        x,y=V('x','index'),V('y','index')
        row=Row(('constant',),(),(x,),((y,N),),(Deferred(y,(x,),lambda args:N),))
        with self.assertRaises(Incomplete):select([row])
    def test_unresolved_competitor_cannot_be_dropped(self):
        x,y=V('x','index'),V('y','index')
        pending=Row(('pending',),(REAL,),(),(),(Deferred(y,(x,),lambda args:N),))
        complete=Row(('complete',),(REAL,),())
        for rows in [[pending,complete],[complete,pending]]:
            with self.assertRaises(Incomplete):select(rows)
    def test_default_does_not_guess_deferred_applicability(self):
        t=V('T','type');out=V('out','index')
        row=Row(('pending',),(t,),(),(),(Deferred(out,(t,),lambda args:N),))
        with self.assertRaises(Incomplete):select([row],default=NAT)
    def test_ground_checks_precede_simultaneous_defaults(self):
        def reject(args):raise NoSolution('checked mismatch')
        bad=Row(('bad',),(REAL,),(),(),(Deferred(N,(),reject),))
        good=Row(('good',),(NAT,),())
        chosen=select_with_trace([bad,good],default=NAT)
        self.assertEqual(chosen.choices,('good',))
        self.assertEqual(chosen.defaulted_positions,())
    def test_distinct_valid_declarations_remain_ambiguous(self):
        rows=[Row((name,),(NAT,),(),(),(Deferred(N,(),lambda args:N),)) for name in ['a','b']]
        with self.assertRaises(Ambiguous):select(rows)
    def test_incomplete_ready_check_is_not_hidden_by_mismatch(self):
        def unknown(args):raise Incomplete('unavailable')
        def reject(args):raise NoSolution('mismatch')
        for checks in [(unknown,reject),(reject,unknown)]:
            row=Row(('row',),(),(),(),tuple(Deferred(N,(),f) for f in checks))
            with self.assertRaises(Incomplete):select([row])
    def test_callback_must_return_ground_value(self):
        for result in [None,V('unresolved','index'),C('Family',(V('T','type'),))]:
            row=Row(('bad',),(),(),(),(Deferred(N,(),lambda args:result),))
            with self.assertRaises(Incomplete):select([row])
    def test_cycle_is_incomplete_not_an_empty_solution(self):
        x,y=V('x','index'),V('y','index')
        row=Row(('cycle',),(),(),(),(Deferred(x,(y,),lambda args:args[0]),Deferred(y,(x,),lambda args:args[0])))
        with self.assertRaises(Incomplete):select([row])
    def test_budget_exhaustion_is_incomplete(self):
        x,y=V('x','index'),V('y','index')
        row=Row(('chain',),(),(y,),(),(Deferred(y,(x,),lambda args:N),Deferred(x,(),lambda args:N)))
        with self.assertRaises(Incomplete):select([row],limit=2)


class JointLiteralConstraints(unittest.TestCase):
    def test_operand_orders_recover_same_dimension(self):
        n=V('literal/n','index');t=V('equality/T','type')
        equations=((t,vector(N)),(t,vector(n)))
        expected=(('vector-zero',),(N,))
        self.assertEqual(select([vector_row(equations)]),expected)
        self.assertEqual(select([vector_row(tuple(reversed(equations)))]),expected)
    def test_rectangular_dimensions_ordered(self):
        m,n=V('m','index'),V('n','index')
        row=Row(('matrix-zero',),(C('Matrix',(m,n,COMPLEX)),),(m,n),
                ((C('Matrix',(m,n,COMPLEX)),C('Matrix',(M,N,COMPLEX))),))
        self.assertEqual(select([row]),(('matrix-zero',),(M,N)))
    def test_square_dimensions_not_guessed(self):
        n=V('n','index')
        row=Row(('identity',),(C('Matrix',(n,n)),),(n,),((C('Matrix',(n,n)),C('Matrix',(M,N))),))
        with self.assertRaises(NoSolution):select([row])
    def test_unconstrained_dimension_is_underdetermined(self):
        with self.assertRaises(Underdetermined):select([vector_row()])
    def test_incomplete_family_blocks_complete_candidate(self):
        complete=Row(('scalar-zero',),(REAL,),())
        for rows in [[complete,vector_row()],[vector_row(),complete]]:
            with self.assertRaises(Underdetermined):select(rows)
    def test_distinct_declarations_remain_ambiguous(self):
        with self.assertRaises(Ambiguous):select([Row(('zero1',),(REAL,),()),Row(('zero2',),(REAL,),())])
    def test_default_does_not_override_forced_vector(self):
        n=V('literal/n','index')
        self.assertEqual(select([vector_row(((n,N),))],default=NAT),(('vector-zero',),(N,)))
    def test_default_can_rule_out_unresolved_vector_family(self):
        row=Row(('nat-zero',),(NAT,),())
        self.assertEqual(select([vector_row(),row],default=NAT),(('nat-zero',),()))
    def test_default_cannot_invent_dimension(self):
        with self.assertRaises(Underdetermined):select([vector_row()],default=NAT)
    def test_defaults_are_simultaneous(self):
        rows=[Row(('nr',),(NAT,REAL),()),Row(('rn',),(REAL,NAT),())]
        for order in [rows,rows[::-1]]:
            with self.assertRaisesRegex(NoSolution,'Simultaneous'):select(order,default=NAT)
    def test_default_does_not_break_same_carrier_tie(self):
        with self.assertRaises(Ambiguous):select([Row(('a',),(NAT,),()),Row(('b',),(NAT,),())],default=NAT)
    def test_enumeration_must_finish(self):
        with self.assertRaises(Incomplete):select([Row(('a',),(NAT,),())],enumeration_complete=False)
    def test_resource_limit_is_not_mismatch(self):
        x=V('x','index');row=Row(('a',),(NAT,),(),((x,N),(x,N)))
        with self.assertRaises(Incomplete):select([row],limit=1)
    def test_occurs_check(self):
        t=V('t','type')
        with self.assertRaises(NoSolution):unify([(t,C('Box',(t,)))])
    def test_sorts_do_not_coerce(self):
        with self.assertRaises(NoSolution):unify([(V('n','index'),REAL)])
    def test_constructor_identity_is_rigid(self):
        with self.assertRaises(NoSolution):unify([(C('Vector/id1',(N,)),C('Vector/id2',(N,)))])
    def test_recovered_argument_must_be_determined(self):
        with self.assertRaises(Underdetermined):select([Row(('a',),(NAT,),(V('proof','evidence'),))])
    def test_conflicting_constraints_reject(self):
        t=V('t','type')
        with self.assertRaises(NoSolution):select([Row(('a',),(t,),(),((t,NAT),(t,REAL)))])

class DefaultTrace(unittest.TestCase):
    def test_trace_records_simultaneous_positions(self):
        rows=[Row(('nn',),(NAT,NAT),()),Row(('rr',),(REAL,REAL),())]
        result=select_with_trace(rows,default=NAT)
        self.assertEqual(result.defaulted_positions,(0,1))
        self.assertEqual(result.default_carrier,NAT)
        self.assertEqual(result.result,select(rows,default=NAT))
        self.assertEqual(result,select_with_trace(rows[::-1],default=NAT))
    def test_context_forced_position_has_no_default_trace(self):
        result=select_with_trace([Row(('r',),(REAL,),())],default=NAT)
        self.assertEqual(result.defaulted_positions,())
        self.assertIsNone(result.default_carrier)

if __name__=='__main__':unittest.main()

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md

# generated: gpt-6 2026-11-11 role=assisted
class ScopedConstraints(unittest.TestCase):
    def test_inner_variable_may_depend_on_its_binder(self):
        x=V('inner/n','index',frozenset({'binder/0'}))
        k=A('bound k','index',frozenset({'binder/0'}))
        self.assertEqual(unify([(x,k)])[x],k)

    def test_outer_variable_cannot_capture_inner_binder(self):
        x=V('outer/n','index');k=A('bound k','index',frozenset({'binder/0'}))
        with self.assertRaises(NoSolution):unify([(x,k)])

    def test_nested_carrier_dependency_cannot_escape(self):
        x=V('outer/T','type');k=A('k','index',frozenset({'binder/0'}))
        with self.assertRaises(NoSolution):unify([(x,vector(k))])

    def test_alias_dependency_checked_in_both_equation_orders(self):
        outer=V('outer','index');inner=V('inner','index',frozenset({'binder/0'}))
        k=A('k','index',frozenset({'binder/0'}))
        for eqs in [[(outer,inner),(inner,k)],[(inner,k),(outer,inner)],[(inner,outer),(inner,k)]]:
            with self.subTest(equations=eqs),self.assertRaises(NoSolution):unify(eqs)

    def test_later_unification_preserves_outer_scope_restriction(self):
        outer=V('outer','index');inner=V('inner','index',frozenset({'binder/0'}))
        bindings=unify([(outer,inner)])
        with self.assertRaises(NoSolution):unify([(inner,A('k','index',frozenset({'binder/0'})))],bindings)

    def test_sibling_binders_are_distinct_despite_same_spelling(self):
        x=V('left/n','index',frozenset({'binder/left'}))
        k=A('k','index',frozenset({'binder/right'}))
        with self.assertRaises(NoSolution):unify([(x,k)])

    def test_closed_solution_satisfies_intersecting_alias_scopes(self):
        left=V('left','index',frozenset({'left'}));right=V('right','index',frozenset({'right'}))
        bindings=unify([(left,right),(right,N)])
        from constraint_model import resolve
        self.assertEqual(resolve(left,bindings),N)

    def test_forward_check_cannot_introduce_escaping_binder(self):
        outer=V('outer','index');k=A('k','index',frozenset({'binder/0'}))
        row=Row(('bad',),(),(outer,),(),(Deferred(outer,(),lambda _:k),))
        with self.assertRaises(NoSolution):saturate(row)

    def test_scope_dependency_resource_exhaustion_is_incomplete(self):
        from constraint_model import check_scopes
        x=V('x','type')
        with self.assertRaises(Incomplete):check_scopes({x:C('Pair',(REAL,REAL))},limit=1)

    def test_scope_metadata_is_immutable(self):
        for constructor in (V,A):
            with self.subTest(constructor=constructor),self.assertRaises(TypeError):
                constructor('x','index',{'binder/0'})


class BinderAbstraction(unittest.TestCase):
    def test_bound_names_have_one_structural_representation(self):
        from constraint_model import Reference,Bound,Binder,abstract
        expected=Binder('Pi',NAT,vector(Bound(0,'index')))
        self.assertEqual(abstract('n',NAT,vector(Reference('n','index'))),expected)
        self.assertEqual(abstract('m',NAT,vector(Reference('m','index'))),expected)
    def test_outer_reference_is_not_discharged(self):
        from constraint_model import Reference,Bound,Binder,abstract
        body=C('Pair',(Reference('n','index'),Reference('outer','index')))
        self.assertEqual(abstract('n',NAT,body),Binder('Pi',NAT,C('Pair',(Bound(0,'index'),Reference('outer','index')))))
    def test_nested_reference_depth_and_domain_scope(self):
        from constraint_model import Reference,Bound,Binder,abstract
        inner=abstract('j',vector(Reference('n','index')),C('Pair',(Reference('n','index'),Reference('j','index'))))
        expected=Binder('Pi',NAT,Binder('Pi',vector(Bound(0,'index')),C('Pair',(Bound(1,'index'),Bound(0,'index')))))
        self.assertEqual(abstract('n',NAT,inner),expected)
    def test_unused_binder_preserves_free_atom(self):
        from constraint_model import abstract,Binder
        self.assertEqual(abstract('n',NAT,vector(N)),Binder('Pi',NAT,vector(N)))
    def test_opaque_dependency_is_not_guessed_from_atom_text(self):
        from constraint_model import abstract
        with self.assertRaises(Incomplete):abstract('n',NAT,vector(A('n + 1','index',frozenset({'n'}))))
    def test_contextual_metavariable_needs_explicit_future_representation(self):
        from constraint_model import abstract
        with self.assertRaises(Incomplete):abstract('n',NAT,V('T','type',frozenset({'n'})))
    def test_scope_independent_metavariable_unifies_under_binder(self):
        from constraint_model import abstract,resolve
        t=V('T','type')
        bindings=unify([(abstract('n',NAT,t),abstract('m',NAT,REAL))])
        self.assertEqual(resolve(t,bindings),REAL)
    def test_local_reference_cannot_solve_outer_metavariable(self):
        from constraint_model import abstract,Reference
        x=V('x','index')
        with self.assertRaises(NoSolution):unify([(abstract('n',NAT,vector(x)),abstract('m',NAT,vector(Reference('m','index'))))])
    def test_free_reference_permissions_remain_checked(self):
        from constraint_model import abstract,Reference
        closed=V('T','type');inner=V('U','type',frozenset({'outer'}))
        typ=abstract('n',NAT,vector(Reference('outer','index')))
        with self.assertRaises(NoSolution):unify([(closed,typ)])
        self.assertEqual(unify([(inner,typ)])[inner],typ)
    def test_occurs_check_visits_binder_domain_and_body(self):
        from constraint_model import Binder
        t=V('T','type')
        for rhs in [Binder('Pi',t,REAL),Binder('Pi',NAT,t)]:
            with self.subTest(rhs=rhs),self.assertRaises(NoSolution):unify([(t,rhs)])
    def test_different_binder_constructor_rejects(self):
        from constraint_model import Binder
        with self.assertRaises(NoSolution):unify([(Binder('Pi',NAT,REAL),Binder('Lambda',NAT,REAL))])
    def test_dangling_bound_input_is_incomplete_even_without_variables(self):
        from constraint_model import Bound,Binder
        for term in [Bound(0,'index'),Binder('Pi',NAT,Bound(1,'index'))]:
            with self.subTest(term=term),self.assertRaises(Incomplete):unify([(term,term)])
    def test_forward_check_can_return_closed_binder(self):
        from constraint_model import abstract,Reference
        t=V('T','type');typ=abstract('n',NAT,vector(Reference('n','index')))
        self.assertEqual(select([Row(('pi',),(),(t,),(),(Deferred(t,(),lambda _:typ),))]),(('pi',),(typ,)))
    def test_sort_preserved_when_resolving_structural_term(self):
        from constraint_model import resolve,abstract
        t=V('t','index');app=C('f',(t,),sort='index')
        self.assertEqual(resolve(app,{t:N}),C('f',(N,),sort='index'))
        self.assertEqual(abstract('unused',NAT,app).body.sort,'index')
    def test_abstraction_resource_limit_is_incomplete(self):
        from constraint_model import abstract,Reference
        with self.assertRaises(Incomplete):abstract('n',NAT,vector(Reference('n','index')),limit=1)
    def test_bound_level_requires_nonnegative_integer(self):
        from constraint_model import Bound
        for level in [-1,True,1.0]:
            with self.subTest(level=level),self.assertRaises(ValueError):Bound(level,'index')


class BinderScopeRegressions(unittest.TestCase):
    def test_outer_alias_cannot_hide_later_bound_escape(self):
        from constraint_model import abstract,Reference
        x,y=V('x','index'),V('y','index')
        bindings=unify([(x,y)])
        with self.assertRaises(NoSolution):
            unify([(abstract('n',NAT,vector(y)),abstract('m',NAT,vector(Reference('m','index'))))],bindings)
    def test_nested_bound_positions_are_not_interchangeable(self):
        from constraint_model import Binder,Bound
        outer=Binder('Pi',NAT,Binder('Pi',NAT,vector(Bound(1,'index'))))
        inner=Binder('Pi',NAT,Binder('Pi',NAT,vector(Bound(0,'index'))))
        with self.assertRaises(NoSolution):unify([(outer,inner)])
    def test_unknown_body_constructor_is_incomplete(self):
        from constraint_model import abstract
        with self.assertRaises(Incomplete):abstract('n',NAT,object())
    def test_binder_scope_check_keeps_domain_dependencies(self):
        from constraint_model import abstract,Reference
        t=V('T','type')
        typ=abstract('n',vector(Reference('outer','index')),REAL)
        with self.assertRaises(NoSolution):unify([(t,typ)])
