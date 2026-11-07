# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
import re,unittest
from cleanlang.core import Environment,Expr,Type,ID
from cleanlang.dependent_functions import fresh_bound,declaration_names

class BoundNameCache(unittest.TestCase):
    def setUp(self):
        self.e=Environment()
        self.local={'x':Expr('x','x',Type('A'))}
    def oracle(self):
        occupied=set(self.local)
        for text in self.e.notation_definitions.values():occupied.update(re.findall(ID,text))
        for value in self.local.values():
            occupied.update(re.findall(ID,value.lean))
            occupied.update(re.findall(ID,self.e.render_type(value.type,'lean')))
        i=0
        while 'clean_pi_bound_'+str(i) in occupied:i+=1
        return 'clean_pi_bound_'+str(i)
    def check(self):
        self.assertEqual(fresh_bound(self.e,self.local),self.oracle())
        self.assertEqual(fresh_bound(self.e,self.local),self.oracle())
    def test_cold_and_warm(self):
        self.e.notation_definitions['f']='def f := clean_pi_bound_0'
        self.check();cached=self.e._bound_declaration_names
        self.check();self.assertIs(cached,self.e._bound_declaration_names)
        self.assertIsInstance(cached[1],frozenset)
    def test_add_replace_delete_text(self):
        self.check()
        self.e.notation_definitions['f']='def f := clean_pi_bound_0';self.check()
        self.e.notation_definitions['f']='def f := clean_pi_bound_1';self.check()
        self.assertEqual(fresh_bound(self.e,self.local),'clean_pi_bound_0')
        self.e.notation_definitions['g']='def g := clean_pi_bound_0';self.check()
        del self.e.notation_definitions['f'];self.check()
    def test_current_local_target_and_type(self):
        self.check()
        self.local['x'].lean='clean_pi_bound_0';self.check()
        self.local['x'].type=Type('clean_pi_bound_1');self.check()
        self.assertEqual(fresh_bound(self.e,self.local),'clean_pi_bound_2')
        self.local['clean_pi_bound_2']=Expr('q','q',Type('A'));self.check()
    def test_type_binding_mutation_is_not_cached(self):
        self.e.data['types']['A']={'lean':'clean_pi_bound_0'};self.check()
        self.e.data['types']['A']['lean']='clean_pi_bound_1';self.check()
    def test_reordered_declarations_same_choice(self):
        self.e.notation_definitions.update(a='clean_pi_bound_0',b='clean_pi_bound_2')
        before=fresh_bound(self.e,self.local)
        self.e.notation_definitions=dict(reversed(list(self.e.notation_definitions.items())))
        self.check();self.assertEqual(fresh_bound(self.e,self.local),before)
    def test_comparison_pool_owns_allocation(self):
        class Pool:
            def __init__(self):self.count=0
            def fresh(self,locals):self.count+=1;return 'owned_'+str(self.count)
        self.e._comparison_pool=Pool()
        self.assertEqual(fresh_bound(self.e,self.local),'owned_1')
        self.assertEqual(fresh_bound(self.e,self.local),'owned_2')
        self.assertFalse(hasattr(self.e,'_bound_declaration_names'))

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
