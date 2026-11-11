# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
import unittest
from itertools import permutations
from contextual_constraints import Family,Occurrence,solve,saturate_contextual
from contextual_terms import Parameter,Actual,apply_solution
from constraint_model import Atom,Carrier,IndexExpression,Reference,Variable,Deferred,Row,resolve,Incomplete,NoSolution
N=Carrier('Natural');C=Carrier('Complex');R=Carrier('Real')
V=lambda n:Carrier('Vector',(n,C))
A=lambda n:Actual(Reference(n,'index'),N)
F=Family('family',(Parameter('n',N,'index'),),'type')

class ContextualConstraints(unittest.TestCase):
 def test_ground_occurrence_constrains_another_scope(self):
  result=Variable('result','type',frozenset({'j'}))
  equations=(('a','k',V(Reference('k','index'))),('b','j',result))
  for entries in permutations(equations):
   solved=solve((),(F,),[Occurrence(i,'family',(A(n),),out) for i,n,out in entries])
   self.assertEqual(resolve(result,solved.bindings),V(Reference('j','index')))
 def test_ordinary_equations_determine_contextual_output(self):
  result=Variable('result','type',frozenset({'k'}))
  solved=solve(((result,V(Reference('k','index'))),),(F,),
   (Occurrence('a','family',(A('k'),),result),))
  self.assertEqual(apply_solution(solved.solutions['family'],(A('j'),)),V(Reference('j','index')))
 def test_consistent_ground_occurrences_have_one_closure(self):
  entries=(Occurrence('a','family',(A('k'),),V(Reference('k','index'))),
           Occurrence('b','family',(A('j'),),V(Reference('j','index'))))
  a=solve((),(F,),entries);b=solve((),(F,),tuple(reversed(entries)))
  self.assertEqual(a.solutions,b.solutions)
 def test_conflicting_occurrences_reject_in_either_order(self):
  entries=(Occurrence('a','family',(A('k'),),R),Occurrence('b','family',(A('j'),),C))
  for order in permutations(entries):
   with self.assertRaises(NoSolution):solve((),(F,),order)
 def test_forward_result_must_respect_destination_scope(self):
  result=Variable('outer','type')
  with self.assertRaises(NoSolution):
   solve((),(F,),(Occurrence('a','family',(A('k'),),V(Reference('k','index'))),
                  Occurrence('b','family',(A('j'),),result)))
 def test_forward_constraint_unlocks_another_family(self):
  second=Family('second',(Parameter('m',N,'index'),),'type')
  x=Variable('x','type',frozenset({'j'}));y=Variable('y','type',frozenset({'z'}))
  entries=(Occurrence('a','family',(A('k'),),V(Reference('k','index'))),
   Occurrence('b','family',(A('j'),),x),Occurrence('c','second',(A('j'),),x),
   Occurrence('d','second',(A('z'),),y))
  for order in (entries,tuple(reversed(entries))):
   solved=solve((),(F,second),order)
   self.assertEqual(resolve(y,solved.bindings),V(Reference('z','index')))
 def test_unresolved_cycles_are_incomplete_without_defaults(self):
  x=Variable('x','type',frozenset({'j'}))
  with self.assertRaises(Incomplete):solve((),(F,),(Occurrence('a','family',(A('j'),),x),))
 def test_unavailable_ready_competitor_is_not_hidden_by_mismatch(self):
  bad=Atom('opaque','type',frozenset({'j'}))
  entries=(Occurrence('a','family',(A('k'),),R),Occurrence('b','family',(A('j'),),C),
           Occurrence('c','family',(A('j'),),bad))
  for order in permutations(entries):
   with self.assertRaises(Incomplete):solve((),(F,),order)
 def test_computed_conflict_is_incomplete_not_inverse_arithmetic(self):
  entries=(Occurrence('a','family',(A('k'),),V(IndexExpression('sum',(Reference('k','index'),Atom('one','index'))))),
           Occurrence('b','family',(A('j'),),V(IndexExpression('other',(Reference('j','index'),)))))
  with self.assertRaises(Incomplete):solve((),(F,),entries)
 def test_sort_mismatch_rejects(self):
  with self.assertRaises(NoSolution):solve((),(F,),(Occurrence('a','family',(A('k'),),Atom('value','index')),))
 def test_unknown_or_duplicate_identifiers_are_incomplete(self):
  occurrence=Occurrence('a','family',(A('k'),),C)
  for families,entries in [((),(occurrence,)),((F,F),(occurrence,)),((F,),(occurrence,occurrence))]:
   with self.assertRaises(Incomplete):solve((),families,entries)
 def test_dependent_telescope_rechecked_at_each_occurrence(self):
  family=Family('dependent',(Parameter('n',N,'index'),Parameter('v',V(Reference('n','index')),'index')),'type')
  result=Variable('result','type',frozenset({'j','y'}))
  solved=solve((),(family,),(
   Occurrence('a','dependent',(A('k'),Actual(Reference('x','index'),V(Reference('k','index')))),V(Reference('k','index'))),
   Occurrence('b','dependent',(A('j'),Actual(Reference('y','index'),V(Reference('j','index')))),result)))
  self.assertEqual(resolve(result,solved.bindings),V(Reference('j','index')))
 def test_type_constraint_unlocks_waiting_actual(self):
  actual_type=Variable('actual type','type')
  result=Variable('result','type')
  second=Family('second',(Parameter('m',N,'index'),),'type')
  solved=solve((),(F,second),(
   Occurrence('a','family',(A('k'),),N),
   Occurrence('b','family',(A('j'),),actual_type),
   Occurrence('c','second',(Actual(Reference('z','index'),actual_type),),C),
   Occurrence('d','second',(A('w'),),result)))
  self.assertEqual(resolve(result,solved.bindings),C)
 def test_forward_checks_and_contextual_families_share_one_fixed_point(self):
  seed=Variable('seed','type');middle=Variable('middle','type');end=Variable('end','type')
  row=Row((),(),(end,),(),(Deferred(seed,(),lambda _:C),Deferred(end,(middle,),lambda xs:Carrier('Wrapped',xs))))
  solved=saturate_contextual(row,(F,),(
   Occurrence('a','family',(A('k'),),seed),Occurrence('b','family',(A('j'),),middle)))
  self.assertEqual(resolve(end,solved.bindings),Carrier('Wrapped',(C,)))
 def test_unavailable_forward_check_dominates_contextual_mismatch(self):
  def unavailable(_):raise Incomplete('unavailable')
  row=Row((),(),(),(),(Deferred(C,(),unavailable),))
  with self.assertRaises(Incomplete):
   saturate_contextual(row,(F,),(
    Occurrence('a','family',(A('k'),),C),Occurrence('b','family',(A('j'),),R)))
 def test_forward_result_must_be_ground(self):
  unknown=Variable('unknown','type')
  row=Row((),(),(),(),(Deferred(C,(),lambda _:unknown),))
  with self.assertRaises(Incomplete):saturate_contextual(row,(),())
 def test_resource_limit_is_incomplete(self):
  with self.assertRaises(Incomplete):solve((),(F,),(Occurrence('a','family',(A('k'),),C),),limit=1)

if __name__=='__main__':unittest.main()

# generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md
