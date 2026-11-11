# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
import tempfile
import unittest
from pathlib import Path
from cleanlang.core import Environment, Expr, Type, LocalType, ValueIndex, Expressions, CleanError, normalize_layout, lean
from cleanlang.modules import load_module, load_document
from cleanlang.structures import declare
from cleanlang import syntax
ROOT=Path(__file__).resolve().parents[1]

class Structures(unittest.TestCase):
    def setUp(self):
        self.e=Environment();load_module(ROOT/'library/topology/bundles.clean',self.e)
        self.local={'X':Expr('X','X',Type('Type')),'P':Expr('P','P',Type('BasedPath',(LocalType('X',(), 'X',0,self.e.data['types']['Type']['native_binding']),))),
                    'I':Expr('I','I',Type('Endpoints')),'a':Expr('a','a',Type('Real')),
                    'b':Expr('b','b',Type('Real'))}
    def expr(self,s):return Expressions(self.e,self.local).parse(s)
    def test_neutral_structure_header(self):
        self.assertEqual(syntax.structure_header('Structure BasedPath(X: Type):'),
                         ['StructureHeader','BasedPath',[['X','Type']]])
        self.assertEqual(syntax.structure_header('sTrUcTuRe Endpoints():'),
                         ['StructureHeader','Endpoints',[]])
    def test_complete_structure_telescope(self):
        self.assertEqual(self.e.structures['BasedPath']['tree'],
            ['Structure','BasedPath',[['X','Type']],
             [['topology','Topology(X)'],['start','X'],['finish','X'],
              ['path','Path(X,topology,start,finish)']],'based path'])
    def test_dot_continuation(self):
        joined=normalize_layout('Let x = P.\n  start')
        self.assertIn('P. start',joined)
    def test_projection_parse_precedence(self):
        tree=lambda s:syntax.expression_tree(syntax.parse(s,'expression'))
        self.assertEqual(tree('I.lower+a'),['Operator','+',['Projection',['Local','I'],'lower'],['Local','a']])
        self.assertEqual(tree('P.outer.inner'),['Projection',['Projection',['Local','P'],'outer'],'inner'])
        self.assertEqual(tree('P.f(a)'),['Apply',['Projection',['Local','P'],'f'],[['Local','a']]])
    def test_index_reference_tree(self):
        self.assertEqual(syntax.type_tree(syntax.parse('Path(X,P.topology,P.start,P.finish)','type_ref')),
            ['Apply','Path',[['Name','X'],['Projection',['Name','P'],'topology'],
                            ['Projection',['Name','P'],'start'],['Projection',['Name','P'],'finish']]])
    def test_projection_target(self):
        self.assertEqual(self.expr('I.lower').type,Type('Real'))
        self.assertEqual(self.expr('I.lower').lean,'(@_root_.'+self.e.structures['Endpoints']['key']+'.«lower» (I))')
    def test_dependent_field_type(self):
        expected=self.e.type('Path(X,P.topology,P.start,P.finish)',self.local)
        self.assertEqual(self.expr('P.path').type,expected)
        self.assertEqual(expected.args[1].name,'P.topology')
    def test_projected_args_to_dependent_call(self):
        result=self.expr('reverse path(P.topology,P.start,P.finish,P.path)')
        self.assertEqual(result.type,self.e.type('Path(X,P.topology,P.finish,P.start)',self.local))
    def test_record_constructor(self):
        self.assertEqual(self.expr('endpoints(a,b)').type,Type('Endpoints'))
        self.assertEqual(self.expr('based path(X,P.topology,P.start,P.finish,P.path)').type,self.local['P'].type)
    def test_explicit_type_substitution(self):
        self.local['Y']=Expr('Y','Y',Type('Type'))
        self.local['Q']=Expr('Q','Q',Type('BasedPath',(LocalType('Y',(), 'Y',0,self.e.data['types']['Type']['native_binding']),)))
        self.assertEqual(self.expr('reversed bundle(Y,Q)').type,self.local['Q'].type)
        with self.assertRaises(CleanError):self.expr('reversed bundle(X,Q)')
    def test_two_records_are_not_interchanged(self):
        self.local['Q']=Expr('Q','Q',self.local['P'].type)
        with self.assertRaisesRegex(CleanError,'index mismatch'):
            self.expr('reverse path(Q.topology,Q.start,Q.finish,P.path)')
    def test_alias_named_value_retains_identity(self):
        self.local['t']=Expr('t','t',self.expr('P.topology').type)
        with self.assertRaisesRegex(CleanError,'index mismatch'):
            self.expr('reverse path(t,P.start,P.finish,P.path)')
    def test_quantified_record_uses_bound_target(self):
        result=self.expr('for every (Q: BasedPath(X), there exists (p: Path(X,Q.topology,Q.start,Q.finish),p=Q.path))')
        self.assertIn('(clean_bound_0)',result.lean)
        self.assertNotIn('(Q)',result.lean)
    def test_nested_record(self):
        declare('Structure Outer():',['Let inner: Endpoints','Constructor: outer'],self.e)
        self.local['O']=Expr('O','O',Type('Outer'))
        self.assertEqual(self.expr('O.inner.lower').type,Type('Real'))
    def test_function_field(self):
        declare('Structure ScalarMap():',['Let map: Function(Real,Real)','Constructor: scalar map'],self.e)
        self.local['M']=Expr('M','M',Type('ScalarMap'))
        self.assertEqual(self.expr('M.map(a)').type,Type('Real'))
        for source in ['M.map()', 'M.map(a,b)', 'I.lower(a)']:
            with self.subTest(source=source),self.assertRaisesRegex(CleanError,'Function field'):
                self.expr(source)
    def test_natural_field_dependency(self):
        declare('Structure SizedVector():',['Let size: Natural','Let vector: Vector(size,Real)',
                                             'Constructor: sized vector'],self.e)
        self.local['V']=Expr('V','V',Type('SizedVector'))
        self.assertEqual(self.expr('V.vector').type,self.e.type('Vector(V.size,Real)',self.local))
        self.assertEqual(self.expr('sized vector(V.size,V.vector)').type,Type('SizedVector'))
    def test_unknown_fields_and_nonrecords(self):
        for source in ['I.missing','a.lower','P.Start']:
            with self.subTest(source=source),self.assertRaises(CleanError):self.expr(source)
    def test_constructor_projection_reduces(self):
        self.assertEqual(self.expr('endpoints(a,b).lower').lean,self.expr('a').lean)
        self.assertEqual(self.expr('shifted endpoints(I,a).lower').lean,self.expr('I.lower+a').lean)
    def test_no_recursive_self_reference(self):
        with self.assertRaises(CleanError):
            declare('Structure Loop():',['Let next: Loop','Constructor: loop'],self.e)
    def test_no_forward_field_reference(self):
        with self.assertRaises(CleanError):
            declare('Structure Bad(X: Type):',['Let p: Path(X,t,x,x)','Let t: Topology(X)',
                                               'Let x: X','Constructor: bad'],self.e)
    def test_group_does_not_bind_its_own_type(self):
        with self.assertRaises(CleanError):
            declare('Structure Bad():',['Let n,v: Vector(n,Real)','Constructor: bad'],self.e)
    def test_duplicate_field_and_param(self):
        for fields in [['Let x,x: Real','Constructor: dup'],['Let X: Real','Constructor: dup']]:
            with self.subTest(fields=fields),self.assertRaises(CleanError):declare('Structure Bad(X: Type):',fields,self.e)
    def test_constructor_is_explicit_and_fresh(self):
        for fields in [['Let x: Real'],['Let x: Real','Constructor: endpoints'],
                       ['Let x: Real','Constructor: Bad'],['Let x: Real','Constructor: Real']]:
            with self.subTest(fields=fields),self.assertRaises(CleanError):declare('Structure Bad():',fields,self.e)
    def test_no_defaults_or_hidden_lean_bodies(self):
        for fields in [['Let x = a','Constructor: bad'],['Let x: Real','Constructor: bad','Means: Unit']]:
            with self.subTest(fields=fields),self.assertRaises(CleanError):declare('Structure Bad():',fields,self.e)
    def test_universe_boundary_is_explicit(self):
        with self.assertRaisesRegex(CleanError,'exceeds declared Universe 0'):
            declare('Structure Space():',['Let carrier: Type','Constructor: space'],self.e)
    def test_metadata_reordering_preserves_target(self):
        other=Environment();load_module(ROOT/'library/topology/bundles.clean',other)
        a=declare('Structure Box():',['Let value: Real','Constructor: box','Describe: a box'],self.e)
        b=declare('Structure Box():',['Describe: a box','Constructor: box','Let value: Real'],other)
        self.assertEqual(a,b);self.assertEqual(self.e.notation_definitions[a],other.notation_definitions[b])
    def test_multiline_header_and_case(self):
        source='Import "'+str(ROOT/'library/topology/basic.clean')+'"\nsTrUcTuRe Box(\n  X: Type\n):\n   lEt value: X\n   cOnStRuCtOr: box\n'
        with tempfile.TemporaryDirectory() as d:
            p=Path(d)/'example.clean';p.write_text(source);env=Environment();load_module(p,env)
        self.assertIn('Box',env.structures)
    def test_attached_documentation(self):
        key=self.e.structures['BasedPath']['key']
        self.assertIn(key,self.e.declaration_docs)
        self.assertIn('/--\nA topology',lean([],self.e,[]))
    def test_real_study(self):
        e=Environment();rs=load_document(ROOT/'studies/topology/Bundles.clean',e)
        self.assertEqual(len(rs),10)
    def test_bad_dots_are_syntax_errors(self):
        for source in ['I..lower','I.','I.(lower)']:
            with self.subTest(source=source),self.assertRaises(CleanError):syntax.parse(source,'expression')
    def test_field_after_application_has_one_tree(self):
        self.assertEqual(syntax.expression_tree(syntax.parse('I.lower.other(a).next','expression')),
            ['Projection',['Apply',['Projection',['Projection',['Local','I'],'lower'],'other'],[['Local','a']]],'next'])
    def test_type_reference_does_not_allow_computation(self):
        with self.assertRaises(CleanError):syntax.parse('Path(X,f(x).t,x,x)','type_ref')

# generated: gpt-6 2026-11-06 role=assisted; LLM-authored portions; see PROVENANCE.md

    def test_computed_projection_tree(self):
        self.assertEqual(syntax.expression_tree(syntax.parse('endpoints(a,b).lower','expression')),
            ['Projection',['Call','endpoints',[['Local','a'],['Local','b']]],'lower'])
    def test_dependent_constructor_projection(self):
        value=self.expr('based path(X,P.topology,P.start,P.finish,P.path).path')
        self.assertEqual((value.lean,value.type,value.tree),
                         (self.expr('P.path').lean,self.expr('P.path').type,self.expr('P.path').tree))
        self.assertEqual(self.expr('reversed bundle(X,P).start').lean,self.expr('P.finish').lean)
    def test_opaque_producer_keeps_projection(self):
        from cleanlang.modules import notation
        notation('Notation opaque endpoints(I: Endpoints): Endpoints:',
                 ['Means: I','Render latex: {I}'],self.e)
        value=self.expr('opaque endpoints(I).lower')
        self.assertEqual(value.tree,['Projection',['Call','opaque endpoints',[['Local','I']]],'lower'])
        self.assertIn(self.e.structures['Endpoints']['key']+'.«lower»',value.lean)
        self.assertNotEqual(value,self.expr('I.lower'))
    def test_computed_function_field(self):
        declare('Structure Evaluation():',['Let map: Function(Real,Real)','Constructor: evaluation'],self.e)
        self.local['f']=Expr('f','f',self.e.type('Function(Real,Real)'))
        self.assertEqual(self.expr('evaluation(f).map(a)').lean,'(f a)')
    def test_bad_constructor_arguments_are_not_erased(self):
        with self.assertRaises(CleanError):self.expr('endpoints(a,P).lower')
    def test_local_alias_stays_opaque(self):
        self.local['J']=Expr('J','J',Type('Endpoints'))
        self.assertEqual(self.expr('J.lower').tree,['Projection',['Local','J'],'lower'])

    def test_implicit_producer_is_not_unfolded(self):
        from cleanlang.modules import notation
        notation('Define retain endpoints(x,I):',
          ['Let X: Type','Let x: X','Let I: Endpoints','Returns: Endpoints','Equals: I'],self.e,authored=True)
        value=self.expr('retain endpoints(a,I).lower')
        self.assertEqual(value.tree[0],'Projection')
        self.assertIn('retain_endpoints',value.lean)
    def test_binder_bearing_producer_is_not_unfolded(self):
        from cleanlang.modules import notation
        declare('Structure ScalarMap():',['Let map: Function(Real,Real)','Constructor: scalar map'],self.e)
        notation('Define identity bundle(): ScalarMap:',
                 ['Equals: scalar map(function(z: Real,z))'],self.e,authored=True)
        value=self.expr('identity bundle().map')
        self.assertEqual(value.tree,['Projection',['Call','identity bundle',[]],'map'])
    def test_index_rendering_does_not_choose_identity(self):
        self.assertEqual(ValueIndex('x','x','first spelling'),ValueIndex('x','x','second spelling'))
        self.assertNotEqual(ValueIndex('x','x','same spelling'),ValueIndex('y','y','same spelling'))
    def test_projection_keeps_authored_rendering(self):
        value=self.expr('endpoints(a,b).lower')
        self.assertEqual(value.lean,'a')
        self.assertIn('endpoints',value.tex)
        self.assertIn('lower',value.tex)

    def test_normal_form_propagates_through_local_calls(self):
        self.local['f']=Expr('f','f',self.e.type('Function(Real,Real)'))
        self.assertEqual(self.expr('f(endpoints(a,b).lower)').tree,
                         ['Call','f',[['Local','a']]])
        self.assertEqual(self.expr('-endpoints(a,b).lower').tree,
                         ['Unary','-',['Local','a']])
