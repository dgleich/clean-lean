# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
from pathlib import Path
import unittest
from cleanlang.core import Environment,Expr,Expressions,Type,CleanError,NUM
from cleanlang.modules import load_module,notation,type_declaration
from cleanlang.structures import declare
ROOT=Path(__file__).resolve().parents[1]
class ClosedUniverses(unittest.TestCase):
    def setUp(self):
        self.e=Environment();load_module(ROOT/'library/logic/equalities.clean',self.e)
        load_module(ROOT/'library/algebra/module_spaces.clean',self.e)
        self.local={}
        for n,t in [('K','Type'),('field','FieldStructure(K)'),('M','CoefficientModule(K,field)')]:
            self.local[n]=Expr(n,n,self.e.type(t,self.local))
    def typ(self,s):return self.e.type(s,self.local)
    def test_declared_levels_and_pi_imax(self):
        for s,level in [('Natural',1),('Type',2),('Proposition',1),
          ('CoefficientModule(K,field)',2),('Function(Natural,CoefficientModule(K,field))',2),
          ('Function(CoefficientModule(K,field),Natural)',2),
          ('Function(MM: CoefficientModule(K,field),(MM = MM))',0),
          ('Function((0 = 0),Natural)',1),('Function(Natural,Proposition)',1)]:
            with self.subTest(s=s):self.assertEqual(self.e.sort_level(self.typ(s)),level)
    def test_confirmed_module_carrier_failure_rejected(self):
        with self.assertRaisesRegex(CleanError,'Type 0; got Type 1'):
            Expressions(self.e,self.local).parse('equality reflexivity(M)')
    def test_original_definition_is_not_published(self):
        with self.assertRaisesRegex(CleanError,'Type 0; got Type 1'):
            notation('Define universe boundary(K,field,M):',[
              'Let K: Type','Let field: FieldStructure(K)',
              'Let M: CoefficientModule(K,field)','Returns: (M = M)',
              'Equals: equality reflexivity(M)'],self.e,authored=True)
        self.assertNotIn('universe boundary',self.e.data['functions'])
    def test_legacy_polymorphic_gate(self):
        notation('Notation hold(x):',['Let T: Type','Let x: T','Returns: T','Means: x','Render latex: {x}'],self.e)
        with self.assertRaisesRegex(CleanError,'Type 0; got Type 1'):
            Expressions(self.e,self.local).parse('hold(M)')
    def test_type_constructor_and_alias_bounds(self):
        type_declaration('Type Family(T: Type):',['Equals: Set(T)'],self.e)
        for s in ['Set(CoefficientModule(K,field))','Family(CoefficientModule(K,field))',
                  'Set(Function(CoefficientModule(K,field),Natural))','Set(Type)']:
            with self.subTest(s=s),self.assertRaisesRegex(CleanError,'Type 0; got Type 1'):self.typ(s)
        self.typ('Set(ModuleElement(K,field,M))')
    def test_arrow_interface_is_not_name_based(self):
        self.e.data['types']['Mapping']=self.e.data['types'].pop('Function')
        t=self.typ('Mapping(CoefficientModule(K,field),Natural)')
        self.assertEqual(self.e.sort_level(t),2)
        self.e.data['types']['Mapping']['lean']='Prod {0} {1}'
        with self.assertRaisesRegex(CleanError,'Type 0'):self.typ('Mapping(CoefficientModule(K,field),Natural)')
    def test_structure_field_bound(self):
        fields=['Let object: CoefficientModule(K,field)','Constructor: module holder']
        header='Structure ModuleHolder(K: Type,field: FieldStructure(K)):'
        with self.assertRaisesRegex(CleanError,'exceeds declared Universe 0'):declare(header,fields,self.e)
        self.assertNotIn('ModuleHolder',self.e.data['types'])
        declare(header,['Universe: 1',*fields],self.e)
        self.assertEqual(self.e.sort_level(self.typ('ModuleHolder(K,field)')),2)
    def test_higher_domain_function_field_requires_large_record(self):
        with self.assertRaisesRegex(CleanError,'exceeds declared Universe 0'):
            declare('Structure BadFunctionHolder(K: Type,field: FieldStructure(K)):',[
              'Let map: Function(CoefficientModule(K,field),Natural)',
              'Constructor: bad map holder'],self.e)
    def test_higher_domain_proof_field_fits_type_zero(self):
        declare('Structure ModuleLaw(K: Type,field: FieldStructure(K)):',[
          'Let law: Function(MM: CoefficientModule(K,field),(MM = MM))',
          'Constructor: module law'],self.e)
        self.assertEqual(self.e.sort_level(self.typ('ModuleLaw(K,field)')),1)
    def test_opaque_binding_uses_explicit_level(self):
        type_declaration('Type Higher():',['Universe: 3','Means: Type 2','Render latex: H'],self.e)
        self.assertEqual(self.e.sort_level(self.typ('Higher')),4)
        with self.assertRaisesRegex(CleanError,'Type 0; got Type 3'):self.typ('Set(Higher)')
    def test_unresolved_literal_is_not_a_type_argument(self):
        with self.assertRaisesRegex(CleanError,'unresolved type'):self.e.require_type_argument(NUM)
        with self.assertRaisesRegex(CleanError,'unresolved type'):
            self.e.call('equality reflexivity',[Expr('0','0',NUM,tree=['Decimal','0'])],self.local)
    def test_completed_literal_has_a_determined_type_argument(self):
        proof=Expressions(self.e,self.local).parse('equality reflexivity(0)')
        self.assertEqual(dict(proof.inferred_args),{'X':self.typ('Natural')})
        self.assertEqual(proof.type,self.typ('Evidence(((0: Natural) = (0: Natural)))'))


# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
