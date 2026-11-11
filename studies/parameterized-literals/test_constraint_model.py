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
