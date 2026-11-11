# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
import unittest
from contextual_terms import Parameter,Actual,Solution,solve_pattern,apply_solution,callable_type
from constraint_model import (Atom,Carrier,IndexExpression,Reference,Bound,Binder,
                              Variable,Incomplete,NoSolution)
N=Carrier('Natural');C=Carrier('Complex')
V=lambda n:Carrier('Vector',(n,C))

class ContextualPatterns(unittest.TestCase):
 def test_dependent_family_solution_is_explicit(self):
  result=solve_pattern((Parameter('n',N,'index'),),(Actual(Reference('k','index'),N),),V(Reference('k','index')))
  self.assertEqual(result.closure,Binder('Context',N,V(Bound(0,'index'))))
  self.assertEqual(apply_solution(result,(Actual(Reference('j','index'),N),)),V(Reference('j','index')))
 def test_dependent_telescope_and_simultaneous_permutation(self):
  params=(Parameter('i',N,'index'),Parameter('v',V(Reference('i','index')),'index'))
  actual=(Actual(Reference('v','index'),N),Actual(Reference('i','index'),V(Reference('v','index'))))
  term=Carrier('Pair',(V(Reference('v','index')),IndexExpression('singleton',(Reference('i','index'),))))
  result=solve_pattern(params,actual,term)
  self.assertEqual(result.closure,Binder('Context',N,Binder('Context',V(Bound(0,'index')),
   Carrier('Pair',(V(Bound(1,'index')),IndexExpression('singleton',(Bound(0,'index'),)))))))
  self.assertEqual(apply_solution(result,actual),term)
 def test_inner_binder_is_not_captured(self):
  term=Binder('Pi',N,Carrier('Pair',(Bound(0,'index'),Reference('k','index'))))
  result=solve_pattern((Parameter('n',N,'index'),),(Actual(Reference('k','index'),N),),term)
  self.assertEqual(result.closure.body.body,Carrier('Pair',(Bound(0,'index'),Bound(1,'index'))))
  self.assertEqual(apply_solution(result,(Actual(Reference('j','index'),N),)),
   Binder('Pi',N,Carrier('Pair',(Bound(0,'index'),Reference('j','index')))))
 def test_constant_solution_preserves_allowed_free_scope(self):
  free=Atom('caller','type',frozenset({'outer'}))
  result=solve_pattern((Parameter('n',N,'index'),),(Actual(Reference('k','index'),N),),free,allowed_free=frozenset({'outer'}))
  self.assertEqual(apply_solution(result,(Actual(Reference('j','index'),N),)),free)
 def test_escape_is_rejected(self):
  with self.assertRaises(NoSolution):
   solve_pattern((Parameter('n',N,'index'),),(Actual(Reference('k','index'),N),),V(Reference('foreign','index')))
 def test_repeated_actual_is_not_a_pattern(self):
  with self.assertRaises(Incomplete):
   solve_pattern((Parameter('n',N,'index'),Parameter('m',N,'index')),
    (Actual(Reference('k','index'),N),)*2,V(Reference('k','index')))
 def test_opaque_dependency_is_incomplete(self):
  with self.assertRaises(Incomplete):
   solve_pattern((Parameter('n',N,'index'),),(Actual(Reference('k','index'),N),),Atom('opaque','type',frozenset({'k'})))
 def test_unresolved_solution_is_incomplete(self):
  with self.assertRaises(Incomplete):
   solve_pattern((Parameter('n',N,'index'),),(Actual(Reference('k','index'),N),),Variable('unknown','type',frozenset({'k'})))
 def test_domain_mismatch_and_future_dependency_reject(self):
  with self.assertRaises(NoSolution):
   solve_pattern((Parameter('n',N,'index'),),(Actual(Reference('k','index'),C),),C)
  with self.assertRaises(NoSolution):
   solve_pattern((Parameter('n',V(Reference('future','index')),'index'),),
    (Actual(Reference('k','index'),V(Reference('future','index'))),),C)
 def test_application_checks_dependent_domain(self):
  params=(Parameter('n',N,'index'),Parameter('v',V(Reference('n','index')),'index'))
  result=solve_pattern(params,(Actual(Reference('k','index'),N),Actual(Reference('x','index'),V(Reference('k','index')))),C)
  with self.assertRaises(NoSolution):
   apply_solution(result,(Actual(Reference('j','index'),N),Actual(Reference('y','index'),V(Reference('other','index')))))
 def test_reference_sort_cannot_be_changed_by_renaming(self):
  with self.assertRaises(NoSolution):
   solve_pattern((Parameter('n',N,'index'),),(Actual(Reference('k','index'),N),),Reference('k','type'))
 def test_malformed_closure_domain_is_rejected(self):
  bad=Solution((Parameter('n',N,'index'),),Binder('Context',C,C),frozenset())
  with self.assertRaises(NoSolution):apply_solution(bad,(Actual(Reference('k','index'),N),))
 def test_alpha_renaming_has_same_closed_solution(self):
  first=solve_pattern((Parameter('n',N,'index'),),(Actual(Reference('k','index'),N),),V(Reference('k','index')))
  second=solve_pattern((Parameter('m',N,'index'),),(Actual(Reference('j','index'),N),),V(Reference('j','index')))
  self.assertEqual(first.closure,second.closure)
 def test_computed_body_is_retained_without_inversion(self):
  body=V(IndexExpression('plus',(Reference('k','index'),Atom('one','index'))))
  result=solve_pattern((Parameter('n',N,'index'),),(Actual(Reference('k','index'),N),),body)
  self.assertEqual(result.closure,Binder('Context',N,V(IndexExpression('plus',(Bound(0,'index'),Atom('one','index'))))))
  self.assertEqual(apply_solution(result,(Actual(Reference('k','index'),N),)),body)
 def test_free_scope_cannot_collide_with_substitution(self):
  with self.assertRaises(Incomplete):
   solve_pattern((Parameter('n',N,'index'),),(Actual(Reference('k','index'),N),),C,allowed_free=frozenset({'k'}))
 def test_foreign_local_named_like_a_formal_cannot_be_captured(self):
  with self.assertRaises(NoSolution):
   solve_pattern((Parameter('n',N,'index'),),(Actual(Reference('k','index'),N),),V(Reference('n','index')))
 def test_callable_type_uses_explicit_function_identity(self):
  result=solve_pattern((Parameter('n',N,'index'),),(Actual(Reference('k','index'),N),),V(Reference('k','index')))
  self.assertEqual(callable_type(result,'DeclaredFunction'),Binder('DeclaredFunction',N,V(Bound(0,'index'))))
 def test_callable_type_rechecks_stored_telescope(self):
  bad=Solution((Parameter('n',N,'index'),),Binder('Context',C,C),frozenset())
  with self.assertRaises(NoSolution):callable_type(bad,'DeclaredFunction')
 def test_index_valued_context_is_not_a_callable_type(self):
  result=solve_pattern((Parameter('n',N,'index'),),(Actual(Reference('k','index'),N),),Reference('k','index'))
  with self.assertRaises(Incomplete):callable_type(result,'DeclaredFunction')
 def test_resource_limit_is_incomplete(self):
  with self.assertRaises(Incomplete):
   solve_pattern((Parameter('n',N,'index'),),(Actual(Reference('k','index'),N),),V(Reference('k','index')),limit=1)

if __name__=='__main__':unittest.main()

# generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md
