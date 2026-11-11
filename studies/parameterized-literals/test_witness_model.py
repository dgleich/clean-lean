# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Independent graph/ordering checks; not a substitute for Lean target validation."""
from dataclasses import dataclass
import unittest
from constraint_model import Atom,Carrier,Variable,Incomplete,NoSolution
from witness_model import Resolver,Seed,Plan

@dataclass(frozen=True)
class Value:
    semantic: object
    spelling: str

def meaning(term):
    if isinstance(term,Carrier):return (term.identity,tuple(meaning(x) for x in term.arguments))
    return int(term.identity) if term.sort=='index' else term.identity

def resolver(seeds=(),plans=(),bindings=None,**kwargs):
    return Resolver(bindings or {},seeds,plans,
        validate=lambda term,value:meaning(term)==value.semantic,
        assemble=lambda term,args:Value((term.identity,tuple(a.semantic for a in args)),
                                       term.identity+'('+','.join(a.spelling for a in args)+')'),**kwargs)

def index(n):return Atom(str(n),'index')
def seed(n,spelling=None,priority=(0,)):
    return Seed(index(n),Value(n,str(n) if spelling is None else spelling),priority)

class WitnessModel(unittest.TestCase):
    def test_checked_seed_is_preserved(self):
        entry=seed(2,'caller n');self.assertIs(resolver([entry]).get(index(2)),entry.value)
    def test_aliases_use_solved_bindings(self):
        a=Variable('a','index');b=Variable('b','index')
        r=resolver([Seed(a,Value(2,'caller n'),(0,))],bindings={a:b,b:index(2)})
        self.assertEqual(r.get(b).spelling,'caller n')
    def test_nominal_carrier_preserves_argument_representatives(self):
        real=Atom('Complex','type');typ=Carrier('Vector',(index(2),real))
        r=resolver([seed(2,'n'),Seed(real,Value('Complex','Complex'),(1,))])
        self.assertEqual(r.get(typ),Value(('Vector',(2,'Complex')),'Vector(n,Complex)'))
    def test_forward_plan_checks_its_computed_result(self):
        plan=Plan(index(3),(index(2),index(1)),lambda xs:Value(sum(x.semantic for x in xs),'n+1'),(2,))
        self.assertEqual(resolver([seed(2,'n'),seed(1)], [plan]).get(index(3)),Value(3,'n+1'))
    def test_duplicate_priority_rejected_after_alias_resolution(self):
        a=Variable('a','index')
        with self.assertRaises(Incomplete):resolver([seed(2),Seed(a,Value(2,'n'),(0,))],bindings={a:index(2)})
    def test_enumeration_order_cannot_choose_spelling(self):
        entries=[seed(2,'later',(9,)),seed(2,'caller',(0,))]
        self.assertEqual(resolver(entries).get(index(2)),resolver(list(reversed(entries))).get(index(2)))
        self.assertEqual(resolver(entries).get(index(2)).spelling,'caller')
    def test_preferred_failure_does_not_fall_through(self):
        plan=Plan(index(2),(index(99),),lambda xs:Value(2,'fallback'),(0,))
        with self.assertRaises(Incomplete):resolver([seed(2,'available',(1,))],[plan]).get(index(2))
    def test_inconsistent_seed_is_not_used(self):
        with self.assertRaises(Incomplete):resolver([Seed(index(2),Value(3,'wrong'),(0,))]).get(index(2))
    def test_cycle_is_incomplete(self):
        plans=[Plan(index(2),(index(3),),lambda _:Value(2,'two'),(0,)),
               Plan(index(3),(index(2),),lambda _:Value(3,'three'),(0,))]
        with self.assertRaisesRegex(Incomplete,'Cyclic'):resolver(plans=plans).get(index(2))
    def test_shared_subplan_built_once(self):
        calls=[]
        def twice(xs):calls.append(1);return Value(2*xs[0].semantic,'twice')
        plans=[Plan(index(2),(index(1),),twice,(0,)),
               Plan(index(4),(index(2),index(2)),lambda xs:Value(sum(x.semantic for x in xs),'sum'),(0,))]
        self.assertEqual(resolver([seed(1)],plans).get(index(4)).semantic,4)
        self.assertEqual(calls,[1])
    def test_unsolved_parameter_is_incomplete(self):
        with self.assertRaises(Incomplete):resolver().get(Variable('n','index'))
    def test_budget_exhaustion_is_incomplete(self):
        with self.assertRaisesRegex(Incomplete,'budget'):resolver([seed(2)],limit=1).get(Carrier('Vector',(index(2),)))
    def test_fresh_resolution_has_no_cross_run_cache(self):
        self.assertEqual(resolver([seed(2,'first')]).get(index(2)).spelling,'first')
        self.assertEqual(resolver([seed(2,'second')]).get(index(2)).spelling,'second')
    def test_failed_plan_is_not_a_candidate_rejection(self):
        def rejected(_):raise NoSolution('unavailable representative')
        with self.assertRaises(Incomplete):resolver(plans=[Plan(index(2),(),rejected,(0,))]).get(index(2))
    def test_declared_seed_precedes_structural_assembly(self):
        typ=Carrier('Vector',(index(2),));entry=Seed(typ,Value(('Vector',(2,)),'V'),(0,))
        self.assertEqual(resolver([entry]).get(typ).spelling,'V')
    def test_deep_graph_exhaustion_is_incomplete(self):
        plans=[Plan(index(i),(index(i+1),),lambda _,i=i:Value(i,str(i)),(0,)) for i in range(1500)]
        r=resolver([seed(1500)],plans,limit=100)
        with self.assertRaises(Incomplete):r.get(index(0))
        self.assertEqual(r.active,set())
    def test_invalid_priority_is_rejected(self):
        with self.assertRaises(ValueError):resolver([seed(2,priority=(True,))])
    def test_cyclic_binding_is_incomplete(self):
        x=Variable('x','index');y=Variable('y','index')
        with self.assertRaises(Incomplete):resolver(bindings={x:y,y:x}).get(x)

if __name__=='__main__':unittest.main()

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md

# generated: gpt-6 2026-11-11 role=assisted
class ScopedWitnesses(unittest.TestCase):
    def test_closed_meaning_does_not_make_source_available(self):
        outer=Variable('outer','index')
        r=resolver([seed(0,'ignore(k)')],bindings={outer:index(0)},
                   available=lambda value,allowed:'k' in allowed,allowed_binders=frozenset({'k'}))
        with self.assertRaises(Incomplete):r.get(outer)

    def test_memo_does_not_bypass_narrower_scope(self):
        inner=Variable('inner','index',frozenset({'k'}));outer=Variable('outer','index')
        r=resolver([seed(0,'ignore(k)')],bindings={inner:index(0),outer:index(0)},
                   available=lambda value,allowed:'k' in allowed,allowed_binders=frozenset({'k'}))
        self.assertEqual(r.get(inner).spelling,'ignore(k)')
        with self.assertRaises(Incomplete):r.get(outer)

    def test_unavailable_preferred_source_does_not_fall_back(self):
        outer=Variable('outer','index')
        r=resolver([seed(0,'ignore(k)',(0,)),seed(0,'0',(1,))],bindings={outer:index(0)},
                   available=lambda value,allowed:value.spelling=='0')
        with self.assertRaises(Incomplete):r.get(outer)

    def test_closed_source_can_be_shared_between_scopes(self):
        outer=Variable('outer','index');inner=Variable('inner','index',frozenset({'k'}))
        r=resolver([seed(0)],bindings={outer:index(0),inner:index(0)},available=lambda value,allowed:True)
        self.assertIs(r.get(outer),r.get(inner))

    def test_failed_scope_check_is_not_candidate_pruning(self):
        def reject(*_):raise NoSolution('Unavailable representation')
        with self.assertRaises(Incomplete):resolver([seed(0)],available=reject).get(index(0))

    def test_scope_check_requires_positive_boolean_evidence(self):
        for answer in (None,False,'unknown',1):
            with self.subTest(answer=answer),self.assertRaises(Incomplete):
                resolver([seed(0)],available=lambda *_:answer).get(index(0))
