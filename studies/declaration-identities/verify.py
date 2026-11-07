# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Compare independent declaration targets across unrelated preceding imports."""
from pathlib import Path
import ast,os,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,normalize_layout
from cleanlang.modules import load_module

environments=[]
for preceding in [False,True]:
    e=Environment()
    if preceding:load_module(HERE/'Unrelated.clean',e)
    load_module(HERE/'Family.clean',e)
    from cleanlang.syntax import structure_header,type_tree,parse,document,let_clause
    record_node=next(n for n in document(normalize_layout((HERE/'Family.clean').read_text())) if n.text.startswith('Structure '))
    assert structure_header(record_node.text)==['StructureHeader','FamilyRecord',[['A','Type']]]
    kind,names,annotation=let_clause(record_node.children[0].text)
    assert (kind,names)==('let',['witness'])
    assert type_tree(parse(annotation,'type_ref'))==['BoundTypeApply','Function','x',['Name','A'],['Apply','Evidence',[['ComputedIndex',['Operator','=', ['Local','x'],['Local','x']]]]]]
    environments.append(e)

imports=[];parts=[];targets=[]
for index,e in enumerate(environments):
    lines=lean([],e,['Lean']).splitlines()
    for line in lines:
        if line.startswith('import ') and line not in imports:imports.append(line)
    namespace='IdentityCase'+str(index)
    parts.append('namespace '+namespace+'\n'+'\n'.join(line for line in lines if not line.startswith('import '))+'\nend '+namespace+'\n')
    # Authored identity selects the declaration; generated spelling is not an API.
    target=e.data['functions']['preserve family']['lean'].split()[0]
    targets.append(namespace+'.'+target)
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
native='\n'.join(imports)+'\n'+''.join(parts)+comparison+r'''
noncomputable def expected_family (f : (x : Nat) → x = x) : (y : Nat) → y = y := f
'''
for target in targets:native+='same_basic_target '+target+' expected_family\n'
native+='same_basic_target '+targets[0]+' '+targets[1]+'\n'
# A kernel-valid changed proof body must still be rejected by the exact oracle.
native+=r'''
noncomputable def changed_family (f : (x : Nat) → x = x) : (y : Nat) → y = y := fun y => Eq.refl y
/-- error: Canonical type or value differs -/
#guard_msgs in
same_basic_target expected_family changed_family
'''
native+=r'''
structure ExpectedRecord (A : Type) : Type where
 witness : (x : A) → x = x
noncomputable def expected_record (A : Type) (witness : (x : A) → x = x) : ExpectedRecord A :=
 @ExpectedRecord.mk A witness

private def identityCanonical (names : List (Name × Name)) : Expr → Expr
 | .const n us => .const ((names.find? (fun p => p.1 == n)).map Prod.snd |>.getD n) us
 | .proj n i b => .proj ((names.find? (fun p => p.1 == n)).map Prod.snd |>.getD n) i (identityCanonical names b)
 | .lam _ t b i => .lam Name.anonymous (identityCanonical names t) (identityCanonical names b) i
 | .forallE _ t b i => .forallE Name.anonymous (identityCanonical names t) (identityCanonical names b) i
 | .letE _ t v b n => .letE Name.anonymous (identityCanonical names t) (identityCanonical names v) (identityCanonical names b) n
 | .app f a => .app (identityCanonical names f) (identityCanonical names a)
 | .mdata _ b => identityCanonical names b
 | e => e
'''
for i,e in enumerate(environments):
    namespace='IdentityCase'+str(i)+'.'
    record=namespace+e.structures['FamilyRecord']['key']
    wrapper=namespace+e.data['functions']['family record']['lean'].split()[0]
    pairs=[(record,'ExpectedRecord'),(record+'.mk','ExpectedRecord.mk'),(record+'.witness','ExpectedRecord.witness'),(wrapper,'expected_record')]
    native+='\nrun_cmd do\n let env ← getEnv\n'
    native+=' let names : List (Name × Name) := [('+ '`'+record+', `ExpectedRecord), (`'+record+'.mk, `ExpectedRecord.mk)]\n'
    native+=' let checks : List (Name × Name) := ['+', '.join('(`'+a+', `'+b+')' for a,b in pairs)+']\n'
    native+=r'''
 for (a,b) in checks do
  let some x := env.find? a | throwError "Missing declaration {a}"
  let some y := env.find? b | throwError "Missing oracle {b}"
  unless x.levelParams == y.levelParams && Expr.equal (identityCanonical names x.type) (identityCanonical names y.type) do
   throwError "Declaration types differ: {a}"
  match x, y with
  | .defnInfo dx, .defnInfo dy =>
    unless Expr.equal (identityCanonical names dx.value) (identityCanonical names dy.value) do
      throwError "Declaration bodies differ: {a}"
  | .thmInfo dx, .thmInfo dy =>
    unless Expr.equal (identityCanonical names dx.value) (identityCanonical names dy.value) do
      throwError "Declaration proof bodies differ: {a}"
  | .inductInfo _, .inductInfo _ => pure ()
  | .ctorInfo _, .ctorInfo _ => pure ()
  | _, _ => throwError "Declaration kinds differ: {a}"
'''
p=HERE/'Verified.lean';p.write_text(native)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Eleven exact declaration checks passed across two environments; changed body rejected')
print('Generated spellings equal:',targets[0].split('.',1)[1]==targets[1].split('.',1)[1])

# generated: gpt-6 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
