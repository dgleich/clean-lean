# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Design-model tests, not Clean parser or translator acceptance evidence."""
import unittest
from pattern_model import Constructor as C,Parameter as P,Fixed as F,Check as K
from pattern_model import match,validate,Ineligible,NoMatch,Incomplete

class PatternModel(unittest.TestCase):
    def run_match(self,pattern,params,actual,**changes):
        options=dict(equal=lambda a,b:a==b,
                     evaluate=lambda identity,args:('computed',identity,args),
                     typed=lambda p,v,earlier:True)
        options.update(changes)
        return match(pattern,params,actual,**options)
    def test_vector_recovers_caller_identity(self):
        caller=('local','caller/n')
        self.assertEqual(self.run_match(C('Vector',(P('formal/n'),F('Complex'))),
            ('formal/n',),C('Vector',(caller,'Complex'))),(caller,))
    def test_rectangular_result_orders_arguments_by_telescope(self):
        self.assertEqual(self.run_match(C('Matrix',(P('m'),P('n'),F('Complex'))),
            ('n','m'),C('Matrix',(2,3,'Complex'))),(3,2))
    def test_repeated_dimension_equal(self):
        self.assertEqual(self.run_match(C('Matrix',(P('n'),P('n'))),('n',),C('Matrix',(3,3))),(3,))
    def test_repeated_dimension_different(self):
        with self.assertRaises(NoMatch):
            self.run_match(C('Matrix',(P('n'),P('n'))),('n',),C('Matrix',(2,3)))
    def test_fixed_carrier_not_interchangeable(self):
        with self.assertRaises(NoMatch):
            self.run_match(C('V',(P('n'),F('Complex'))),('n',),C('V',(3,'Real')))
    def test_renaming_has_no_mathematical_dispatch(self):
        self.assertEqual(self.run_match(C('user/id17',(P('p'),)),('p',),C('user/id17',(8,))),(8,))
    def test_constructor_identity_not_display_name(self):
        with self.assertRaises(NoMatch):self.run_match(C('id1',()),(),C('id2',()))
    def test_arity_mismatch(self):
        with self.assertRaises(NoMatch):self.run_match(C('V',(P('n'),)),('n',),C('V',()))
    def test_computed_only_is_ineligible(self):
        with self.assertRaises(Ineligible):validate(C('V',(K('succ',('n',)),)),('n',))
    def test_absent_evidence_parameter_is_ineligible(self):
        with self.assertRaises(Ineligible):validate(C('V',(P('n'),)),('n','proof'))
    def test_unknown_dependency_is_ineligible(self):
        with self.assertRaises(Ineligible):validate(C('V',(K('f',('unknown',)),)),())
    def test_computed_before_direct_is_deferred(self):
        result=('computed','succ',(3,))
        self.assertEqual(self.run_match(C('M',(K('succ',('n',)),P('n'))),
            ('n',),C('M',(result,3))),(3,))
    def test_computed_constraint_mismatch(self):
        with self.assertRaises(NoMatch):
            self.run_match(C('M',(P('n'),K('succ',('n',)))),('n',),C('M',(3,3)))
    def test_parameter_type_must_check(self):
        with self.assertRaises(NoMatch):
            self.run_match(C('V',(P('n'),)),('n',),C('V',('wrong sort',)),typed=lambda *args:False)
    def test_dependent_parameter_telescope(self):
        seen=[]
        def typed(p,v,earlier):seen.append((p,v,earlier));return True
        self.run_match(C('V',(P('value'),P('type'))),('type','value'),C('V',(3,'Nat')),typed=typed)
        self.assertEqual(seen,[('type','Nat',{}),('value',3,{'type':'Nat'})])
    def test_incomplete_equality_not_mismatch(self):
        with self.assertRaises(Incomplete):
            self.run_match(C('V',(F('A'),)),(),C('V',('B',)),equal=lambda *args:None)
    def test_incomplete_type_not_mismatch(self):
        with self.assertRaises(Incomplete):
            self.run_match(C('V',(P('n'),)),('n',),C('V',(3,)),typed=lambda *args:None)
    def test_callback_error_propagates(self):
        def invalid(*args):raise RuntimeError('invalid environment')
        with self.assertRaisesRegex(RuntimeError,'invalid environment'):
            self.run_match(C('V',(F('A'),)),(),C('V',('B',)),equal=invalid)
    def test_bare_parameter_result_is_ineligible(self):
        with self.assertRaises(Ineligible):validate(P('T'),('T',))
    def test_duplicate_formal_identity_is_ineligible(self):
        with self.assertRaises(Ineligible):validate(C('V',(P('n'),)),('n','n'))

if __name__=='__main__':unittest.main()

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
