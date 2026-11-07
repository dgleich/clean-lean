# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from cleanlang.core import Environment,Expr,Expressions,Type,NAT
from cleanlang.modules import load_module
from cleanlang.syntax import parse,expression_tree,expression_spelling
from cleanlang.hygiene import substitute
from cleanlang.conversion import comparison_normal_form,local_definition
ROOT=Path(__file__).resolve().parents[1]
class HygienicSubstitution(unittest.TestCase):
    def test_name_scanner_raw_annotations_and_binders(self):
        from cleanlang.dependent_functions import tree_names
        cases=[(['TypeValue','Natural'],{'Natural'}),
               (['Lambda','x','Real',['Local','x']],{'x','Real'}),
               (['Forall','x','Real',['Local','P']],{'x','Real','P'}),
               (['NumeralAnnotation','1',['Name','Real']],{'Real'})]
        for tree,expected in cases:
            with self.subTest(tree=tree):self.assertEqual(tree_names(tree),expected)

    def setUp(self):
        self.e=Environment();load_module(ROOT/'library/operators.clean',self.e)
    def tree(self,s):return expression_tree(parse(s,'expression'))
    def test_capture_and_simultaneous_insertion(self):
        t=self.tree('function(y: Real,x + y)')
        bindings={'x':Expr('y','y',Type('Real'),tree=['Local','y']),
                  'y':Expr('z','z',Type('Real'),tree=['Local','z'])}
        result=substitute(t,bindings,self.e,{'y':bindings['x']})
        self.assertEqual(result,['Lambda','clean_conversion_bound_0','Real',
          ['Operator','+',['Local','y'],['Local','clean_conversion_bound_0']]])
    def test_value_substitution_does_not_derive_callable_view(self):
        from unittest.mock import patch
        value=Expr('p','p',Type('ConditionEvidence'),tree=['Local','p'])
        with patch.object(self.e,'is_function_type',side_effect=AssertionError('unused callable view')):
            self.assertEqual(substitute(['Local','h'],{'h':value},self.e,{}),['Local','p'])
            self.assertEqual(substitute(['Decimal','0'],{'h':value},self.e,{}),['Decimal','0'])
    def test_call_head_checked_once_and_noncallable_preserved(self):
        from unittest.mock import patch
        tree=['Operator','+',['Call','f',[['Decimal','0']]],['Call','f',[['Decimal','1']]]]
        value=Expr('g','g',Type('SomeType'),tree=['Local','g'])
        for callable_value,head in [(True,'g'),(False,'f')]:
            with patch.object(self.e,'is_function_type',return_value=callable_value) as check:
                result=substitute(tree,{'f':value},self.e,{})
                self.assertEqual(result,['Operator','+',['Call',head,[['Decimal','0']]],['Call',head,[['Decimal','1']]]])
                check.assert_called_once_with(value.type)
    def test_unused_actual_still_reserves_binder_names(self):
        value=Expr('p','p',NAT,tree=['Local','clean_conversion_bound_0'])
        result=substitute(self.tree('function(x: Natural,x)'),{'unused':value},self.e,{})
        self.assertEqual(result,['Lambda','clean_conversion_bound_1','Natural',['Local','clean_conversion_bound_1']])
    def test_call_head_in_condition_annotation(self):
        from unittest.mock import patch
        value=Expr('g','g',Type('SomeType'),tree=['Local','g'])
        tree=['Lambda','h','Evidence((f(0) = 0))',['Local','h']]
        with patch.object(self.e,'is_function_type',return_value=True) as check:
            result=substitute(tree,{'f':value},self.e,{})
            self.assertIn('g(0)',result[2])
            check.assert_called_once_with(value.type)
    def test_dependent_domain_substitution(self):
        t=self.tree('function(v: Vector(n,Real),v)')
        actual=Expr('(m + m)','',NAT,tree=self.tree('m + m'))
        result=substitute(t,{'n':actual},self.e,{'m':Expr('m','m',NAT)})
        self.assertEqual(result[2],'Vector(((m + m)),Real)')
        Expressions(self.e,{'m':Expr('m','m',NAT)}).elaborate(result)
    def test_nested_type_binder_hygiene(self):
        t=self.tree('function(f: Function(n: Natural,Vector(n,T)),f)')
        result=substitute(t,{'T':Expr('R','R',Type('Type'),tree=['Local','R'])},self.e,{})
        self.assertEqual(result[2],'Function(clean_conversion_bound_0: Natural,Vector(clean_conversion_bound_0,R))')
        self.assertEqual(result[1],'clean_conversion_bound_1')
    def test_function_heads_and_field_labels(self):
        t=self.tree('function(x: Real,f(x))')
        f=Expr('g','g',self.e.type('Function(Real,Real)'),tree=['Local','g'])
        result=substitute(t,{'f':f},self.e,{})
        self.assertEqual(result[3],['Call','g',[['Local',result[1]]]])
        t=['Projection',['Local','r'],'f']
        self.assertEqual(substitute(t,{'f':f},self.e,{}),t)
    def test_quantifier_binder_and_freshness(self):
        t=self.tree('for every (x: Real,x = y)')
        local={'clean_conversion_bound_0':Expr('q','q',Type('Real'))}
        y=Expr('x','x',Type('Real'),tree=['Local','x'])
        result=substitute(t,{'y':y},self.e,local)
        self.assertEqual(result[1],'clean_conversion_bound_1')
        self.assertEqual(result[3][3],['Local','x'])
    def test_computed_field_application_roundtrip(self):
        for source in ['build(x).component(p)','(build(x).component(p)).value(q)']:
            tree=self.tree(source)
            self.assertEqual(self.tree(expression_spelling(tree)),tree)

class GradedConversion(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.e=Environment();load_module(ROOT/'library/topology/graded_homology_maps.clean',cls.e)
    def setUp(self):
        self.local={}
        for n,t in [('K','Type'),('field','FieldStructure(K)'),('X','TopologicalSpace'),('Y','TopologicalSpace'),
                    ('g','ContinuousMap(X,Y)'),('p','Natural')]:
            self.local[n]=Expr(n,n,self.e.type(t,self.local))
    def expr(self,s):return Expressions(self.e,self.local).parse(s)
    def normal(self,s):return comparison_normal_form(self.expr(s),self.e,self.local)
    def test_applied_component_and_original_target(self):
        source='graded singular homology(K,field,X).component(p)'
        before=self.expr(source)
        expected=self.normal('homology module(field,scalar homology(K,field,p),X)')
        self.assertEqual(self.normal(source).lean,expected.lean)
        self.assertIn('cleanDefine_graded_singular_homology',before.lean)
        self.assertEqual(self.expr(source).lean,before.lean)
    def test_unapplied_family_remains_opaque(self):
        source='graded singular homology(K,field,X)'
        self.assertEqual(self.normal(source).lean,self.expr(source).lean)
    def test_local_alias_then_later_compiler_like_name(self):
        self.local['M']=local_definition('M',self.expr('graded singular homology(K,field,X)'),self.e,self.local)
        self.local['clean_conversion_bound_0']=Expr('clean_conversion_bound_0','q',NAT)
        self.assertEqual(self.normal('M.component(p)').lean,
          self.normal('homology module(field,scalar homology(K,field,p),X)').lean)
    def test_authored_induced_map(self):
        self.assertEqual(self.e.definitions['graded homology map']['implementation'],'equals')
        expected=self.normal('homology linear map(field,scalar homology(K,field,p),X,Y,g)')
        self.assertEqual(self.normal('graded homology map(K,field,X,Y,g).component(p)').lean,expected.lean)

class FrozenResolution(unittest.TestCase):
    def setUp(self):
        from cleanlang.modules import notation
        self.e=Environment();load_module(ROOT/'library/operators.clean',self.e)
        notation('Notation square(x: Real): Real:', ['Means: x*x','Render latex: {x}^2'],self.e)
        notation('Define squared(x: Real): Real:', ['Equals: square(x)'],self.e,authored=True)
    def test_caller_function_cannot_rebind_definition_body(self):
        local={'x':Expr('x','x',Type('Real')),
               'square':Expr('other','other',self.e.type('Function(Real,Real)'))}
        value=Expressions(self.e,local).parse('squared(x)')
        self.assertEqual(comparison_normal_form(value,self.e,local).lean,value.lean)
    def test_later_callable_cannot_rebind_cached_local(self):
        local={'x':Expr('x','x',Type('Real'))}
        value=Expressions(self.e,local).parse('squared(x)')
        local['v']=local_definition('v',value,self.e,local)
        old=local['v'].local_normal.lean
        local['square']=Expr('other','other',self.e.type('Function(Real,Real)'))
        result=comparison_normal_form(Expressions(self.e,local).parse('v'),self.e,local)
        self.assertEqual(result.lean,old)
        self.assertNotIn('other',result.lean)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md

# generated: gpt-6 2026-11-07 role=assisted
class SelectedProducerField(unittest.TestCase):
    def setUp(self):
        from cleanlang.structures import declare
        from cleanlang.modules import notation
        self.e=Environment();load_module(ROOT/'library/operators.clean',self.e)
        declare('Structure FieldPair(T: Type):',[
            'Let item: T','Let action: Function(T,T)','Constructor: field pair'],self.e)
        notation('Define field producer(x):',[
            'Let T: Type','Let x: T','Returns: FieldPair(T)',
            'Equals: field pair(T,x,function(y: T,x))'],self.e,authored=True)
        notation('Define field wrapper(x):',[
            'Let T: Type','Let x: T','Returns: FieldPair(T)',
            'Equals: field producer(x)'],self.e,authored=True)
        notation('Notation native producer(x):',[
            'Let T: Type','Let x: T','Returns: FieldPair(T)',
            'Means: nativeFieldProducer x','Render latex: native({x})'],self.e)
        self.local={'x':Expr('x','x',Type('Real'),tree=['Local','x'])}
    def test_selects_field_without_elaborating_constructor_siblings(self):
        from cleanlang.conversion import _producer_field
        from unittest.mock import patch
        original=Expressions.elaborate
        value=Expressions(self.e,self.local).parse('field producer(x)')
        def checked(instance,tree):
            if tree[0]=='Call' and tree[1]=='field pair':
                raise AssertionError('Unselected constructor fields were elaborated')
            return original(instance,tree)
        with patch.object(Expressions,'elaborate',checked):
            selected=_producer_field(value,'item',self.e,self.local)
        self.assertEqual(selected.tree,['Local','x'])
        self.assertEqual(selected.lean,'x')
    def test_wrapped_field_compares_without_changing_emission(self):
        value=Expressions(self.e,self.local).parse('field wrapper(x).item')
        before=value.lean
        self.assertIn('cleanDefine_field_wrapper',before)
        self.assertEqual(comparison_normal_form(value,self.e,self.local).lean,'x')
        self.assertEqual(Expressions(self.e,self.local).parse('field wrapper(x).item').lean,before)
    def test_native_producer_stays_opaque(self):
        from cleanlang.conversion import _producer_field
        value=Expressions(self.e,self.local).parse('native producer(x)')
        self.assertIsNone(_producer_field(value,'item',self.e,self.local))
    def test_shadowed_module_stays_opaque(self):
        from cleanlang.conversion import _producer_field
        value=Expressions(self.e,self.local).parse('field producer(x)')
        shadow={**self.local,'Vector':Expr('Vector','Vector',Type('Type'),tree=['Local','Vector'])}
        self.assertIsNone(_producer_field(value,'item',self.e,shadow))
    def test_function_field_retains_capture_free_binder(self):
        self.local['y']=Expr('y','y',Type('Real'),tree=['Local','y'])
        value=Expressions(self.e,self.local).parse('field producer(x).action(y)')
        self.assertEqual(comparison_normal_form(value,self.e,self.local).lean,'x')
    def test_original_call_still_checks_unused_actuals(self):
        from cleanlang.core import CleanError
        with self.assertRaises(CleanError):
            Expressions(self.e,self.local).parse('field pair(type(Real),x,x).item')
