# generated: gpt-6 2026-10-30 role=assisted; LLM-authored portions; see PROVENANCE.md
import tempfile
import unittest
from pathlib import Path
from cleanlang.core import Environment, CleanError, lean, latex
from cleanlang.modules import load_document
from cleanlang.conditions import source_expression
ROOT=Path(__file__).resolve().parents[1]
PRELUDE='''Import "COMMON"
Source tests:
  Kind: other
  Label: Tests
  Title: Condition tests
Condition positive(x: Real):
  Holds when: x > 0
  Assumption name: positivity of {x}
Condition related(x: Real,y: Real):
  Holds when: x = y
Condition accepted(p: Function(Real,Proposition)):
  Holds when: p(0)
'''.replace('COMMON',str(ROOT/'library/Common.clean'))
RESULT='''Result example:
  Attribution: tests; example; original
  Let x,y: Real
  ASSUMe positive(x), positive(y)
  Conclude: x > 0 and y > 0
'''

class Conditions(unittest.TestCase):
    def load(self, source=RESULT, prelude=PRELUDE):
        with tempfile.TemporaryDirectory() as tmp:
            path=Path(tmp)/'test.clean';path.write_text(prelude+'\n'+source)
            env=Environment();results=load_document(path,env)
            return env,results

    def test_independent_ast_and_binders(self):
        env,rs=self.load();r=rs[0]
        self.assertEqual(env.definitions['positive']['tree'],['Operator','>',['Local','x'],['Decimal','0']])
        self.assertEqual([(c.label,c.names,c.value.tree) for c in r.clauses if c.kind=='assume'],[
            ('positivity of x',['positivity_of_x'],['Call','positive',[['Local','x']]]),
            ('positivity of y',['positivity_of_y'],['Call','positive',[['Local','y']]])])
        target=lean(rs,env,[])
        self.assertIn('∀ («positivity_of_x» :',target)
        self.assertIn('positivity of x',latex(rs,env))

    def test_nested_commas_colons_and_mixed_labels(self):
        env,rs=self.load(RESULT.replace('positive(x), positive(y)',
            'related(x,y), accepted(function(z: Real, z > 0)), both: positive(x) and positive(y)'))
        assumptions=[c for c in rs[0].clauses if c.kind=='assume']
        self.assertEqual(len(assumptions),3)
        self.assertEqual(assumptions[0].label,'related(x, y)')
        self.assertEqual(assumptions[2].value.tree[0:2],['Operator','∧'])

    def test_continuation_and_block_body(self):
        a,ar=self.load()
        b,br=self.load(RESULT.replace('positive(x), positive(y)','positive(x),\n    positive(y)'),
            PRELUDE.replace('Holds when: x > 0','Holds when:\n    x > 0'))
        self.assertEqual(lean(ar,a,[]),lean(br,b,[]))

    def test_keyword_named_condition_continues(self):
        prelude=PRELUDE.replace('Condition positive(', 'Condition condition(')
        source=RESULT.replace('positive(', 'condition(')
        a,ar=self.load(source,prelude)
        b,br=self.load(source.replace('condition(x), condition(y)','condition(x),\n    condition(y)'),prelude)
        self.assertEqual(lean(ar,a,[]),lean(br,b,[]))

    def test_collisions(self):
        for expr in ('positive(x), positive((x))','positive(x), positivity_of_x: positive(y)',
                     'positive(x), positivity of x: positive(y)'):
            with self.subTest(expr=expr),self.assertRaisesRegex(CleanError,'Duplicate'):
                self.load(RESULT.replace('positive(x), positive(y)',expr))
        with self.assertRaisesRegex(CleanError,'Duplicate'):
            self.load(RESULT.replace('Let x,y: Real','Let x,y,positivity_of_x: Real'))
        with self.assertRaisesRegex(CleanError,'duplicate'):
            self.load(RESULT.replace('Conclude:', 'Let positivity_of_x: Real\n  Conclude:'))

    def test_invalid_lists_and_non_condition_calls(self):
        for expr in ('positive(x),','positive(x),,positive(y)','positive(x); positive(y)',
                     'x > 0','positive(x) and positive(y)','not positive(x)',
                     'a:b: positive(x)','Positive(x)'):
            with self.subTest(expr=expr),self.assertRaises(CleanError):
                self.load(RESULT.replace('positive(x), positive(y)',expr))

    def test_invalid_declarations(self):
        for old,new in [('Assumption name: positivity of {x}','Assumption name: {unknown}'),
                        ('Assumption name: positivity of {x}','Assumption name: {x!r}'),
                        ('Condition positive(x: Real):','Condition positive(x: Real): Real:'),
                        ('Holds when: x > 0','Holds when: x + 1'),
                        ('Holds when: x > 0','Returns: Proposition\n  Holds when: x > 0'),
                        ('Holds when: x > 0','Equals: x > 0'),
                        ('Holds when: x > 0','From Lean: x > 0\n  Holds when: x > 0')]:
            with self.subTest(new=new),self.assertRaises(CleanError):
                self.load(prelude=PRELUDE.replace(old,new))

    def test_labels_are_not_expressions(self):
        with self.assertRaises(CleanError):
            self.load(RESULT.replace('Conclude: x > 0 and y > 0','Conclude: positivity_of_x'))
        with self.assertRaisesRegex(CleanError,'Local condition abbreviations'):
            self.load(RESULT.replace('ASSUMe positive(x), positive(y)','Define p = x > 0'))

    def test_context_counts_and_collisions(self):
        src='''Context outer:
  Let x,y: Real
  Assume positive(x), positive(y)
  Context inner:
    Assume same: related(x,y)
    Result example:
      Attribution: tests; example; original
      Assume again: positive(x)
      Conclude: x > 0
'''
        env,rs=self.load(src);r=rs[0]
        self.assertEqual([len(c.clauses) for c in r.contexts],[3,1])
        self.assertEqual([c.names for c in r.local_clauses],[['again']])
        self.assertEqual([c.names for c in r.clauses if c.kind=='assume'],
                         [['positivity_of_x'],['positivity_of_y'],['same'],['again']])
        self.assertEqual(latex(rs,env).count('positivity of y'),2)
        with self.assertRaisesRegex(CleanError,'Duplicate'):
            self.load(src.replace('Assume again: positive(x)','Assume positive(x)'))

    def test_default_and_compound_names(self):
        env,rs=self.load(RESULT.replace('positive(x), positive(y)','related(x+y,y), related(x-y,y)'))
        a=[c for c in rs[0].clauses if c.kind=='assume']
        self.assertNotEqual(a[0].names,a[1].names)
        self.assertEqual(a[0].label,'related((x + y), y)')
        self.assertEqual(source_expression(['Decimal','000']),'0')

    def test_imported_condition(self):
        env,rs=self.load(prelude=PRELUDE.replace('Holds when: x > 0','From Lean: x > 0'))
        self.assertEqual(env.definitions['positive']['implementation'],'from lean')
        self.assertEqual(rs[0].clauses[1].label,'positivity of x')

    def test_zero_arguments_and_template_literals(self):
        prelude=PRELUDE+"\nCondition always():\n  Holds when: 0 = 0\n  Assumption name: {{always}}\n"
        env,rs=self.load(RESULT.replace('positive(x), positive(y)','always()'),prelude)
        self.assertEqual(rs[0].clauses[1].label,'{always}')
        for value in ('', '{', '{x:bad}'):
            with self.subTest(value=value),self.assertRaises(CleanError):
                self.load(prelude=PRELUDE.replace('positivity of {x}',value))

    def test_encoding_and_display_collisions(self):
        prelude=PRELUDE.replace('positivity of {x}','+')
        with self.assertRaisesRegex(CleanError,'Duplicate'):
            self.load(RESULT.replace('positive(x), positive(y)','positive(x), _u2b_: positive(y)'),prelude)
        with self.assertRaisesRegex(CleanError,'Duplicate'):
            self.load(RESULT.replace('Let x,y: Real','Let x,y,x__y: Real').replace(
                'positive(x), positive(y)','x__y: positive(x)'))

    def test_missing_or_wrong_foundational_binding(self):
        from cleanlang.modules import condition_declaration
        env=Environment()
        with self.assertRaisesRegex(CleanError,'foundational'):
            condition_declaration('Condition always():',['Holds when: 0 = 0'],env)
        env.data['types']['Proposition']={'args':[],'lean':'Real'}
        with self.assertRaisesRegex(CleanError,'foundational'):
            condition_declaration('Condition always():',['Holds when: 0 = 0'],env)

    def test_local_function_cannot_borrow_condition_name(self):
        with self.assertRaisesRegex(CleanError,'Automatic assumption'):
            self.load(RESULT.replace('Let x,y: Real','Let x,y: Real\n  Let positive: Function(Real,Proposition)'))
