# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Check authored records, generated constructors/projections, and bundle results."""
from pathlib import Path
import os, subprocess, sys
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
here=Path(__file__).resolve().parent
env=Environment();results=load_document(here/'Bundles.clean',env)
source=lean(results,env,['Lean'])
(here/'Bundles.lean').write_text(source)
(here/'Bundles.tex').write_text(latex(results,env))
keys={n:d['key'] for n,d in env.definitions.items()}
pkey=env.structures['BasedPath']['key'];ikey=env.structures['Endpoints']['key']
skey=env.structures['ScalarMap']['key'];vkey=env.structures['SizedVector']['key']
rkey=env.data['functions']['reverse path']['dependent_signature']['key']
mapping={'BundleOracle.BasedPath':pkey,'BundleOracle.Endpoints':ikey,
         'BundleOracle.makePath':keys['based path'],'BundleOracle.endpoints':keys['endpoints'],
         'BundleOracle.reverse':keys['reversed bundle'],'BundleOracle.shift':keys['shifted endpoints'],
         'BundleOracle.ordered':keys['ordered endpoints'],'BundleOracle.reversePath':rkey,
         'BundleOracle.ScalarMap':skey,'BundleOracle.SizedVector':vkey,
         'BundleOracle.scalarMap':keys['scalar map'],'BundleOracle.sizedVector':keys['sized vector']}
mapping['BundleOracle.nativeIdentity']=env.data['functions']['opaque endpoints']['native_binding']
for oracle,name in [('carrierType','Type'),('realType','Real'),('naturalType','Natural'),
                    ('conditionType','Proposition'),('topologyType','Topology'),
                    ('pathType','Path'),('vectorType','Vector')]:
    mapping['BundleOracle.'+oracle]=env.data['types'][name]['native_binding']
for oracle,name in [('equal','equal'),('both','conjunction'),('add','real sum'),('less','real less')]:
    mapping['BundleOracle.'+oracle]=env.data['functions'][name]['native_binding']
rename='\n'.join(f'  if n == `{a} then return `{b}' for a,b in mapping.items())
comparison='''
open Lean Elab Command
private def canonicalName (n : Name) : Name := Id.run do
'''+rename+'''
  match n with
  | .str p s => return .str (canonicalName p) s
  | .num p i => return .num (canonicalName p) i
  | .anonymous => return .anonymous
private def canonical : Expr → Expr
  | .const n u => .const (canonicalName n) u
  | .lam _ t b i => .lam Name.anonymous (canonical t) (canonical b) i
  | .forallE _ t b i => .forallE Name.anonymous (canonical t) (canonical b) i
  | .letE _ t v b n => .letE Name.anonymous (canonical t) (canonical v) (canonical b) n
  | .app f a => .app (canonical f) (canonical a)
  | .mdata _ b => canonical b
  | .proj n i b => .proj (canonicalName n) i (canonical b)
  | e => e
elab "same_target " a:ident b:ident : command => do
  let env ← getEnv
  let some x := env.find? a.getId | throwError "Missing actual target"
  let some y := env.find? b.getId | throwError "Missing expected target"
  unless x.levelParams == y.levelParams && Expr.equal (canonical x.type) (canonical y.type) do
    throwError "Canonical type differs: {a} vs {b}"
  match x,y with
  | .defnInfo x,.defnInfo y =>
    unless Expr.equal (canonical x.value) (canonical y.value) do
      throwError "Canonical body differs: {a} vs {b}"
  | .ctorInfo x,.ctorInfo y =>
    unless x.numParams == y.numParams && x.numFields == y.numFields && x.cidx == y.cidx &&
        canonicalName x.induct == canonicalName y.induct do
      throwError "Constructor shape differs"
  | .inductInfo x,.inductInfo y =>
    unless x.numParams == y.numParams && x.numIndices == y.numIndices &&
        x.isRec == y.isRec && x.ctors.map canonicalName == y.ctors.map canonicalName do
      throwError "Structure shape differs"
  | _,_ => throwError "Unexpected declaration kinds"
'''
expected='''
namespace BundleOracle
noncomputable abbrev carrierType : Type 1 := Type
noncomputable abbrev realType : Type := ℝ
noncomputable abbrev naturalType : Type := ℕ
noncomputable abbrev conditionType : Sort 1 := Prop
noncomputable abbrev topologyType (X : Type) : Type := TopologicalSpace X
noncomputable abbrev pathType (X : Type) (t : topologyType X) (x y : X) : Type := @Path X t x y
noncomputable abbrev vectorType (n : Nat) (T : Type) : Type := Fin n → T
noncomputable def equal {T : Type} (x y : T) : conditionType := x=y
noncomputable def both (x y : conditionType) : conditionType := x ∧ y
noncomputable def add (x y : realType) : realType := x+y
noncomputable def less (x y : realType) : conditionType := x<y
structure BasedPath (X : Type) : Type where
  topology : topologyType X
  start : X
  finish : X
  path : pathType X topology start finish
structure Endpoints : Type where
  lower : realType
  upper : realType
structure ScalarMap : Type where
  map : realType → realType
structure SizedVector : Type where
  size : naturalType
  vector : vectorType size realType
noncomputable def scalarMap (f : realType → realType) : ScalarMap := @ScalarMap.mk f
noncomputable def sizedVector (n : naturalType) (v : vectorType n realType) : SizedVector := @SizedVector.mk n v
noncomputable def makePath (X : Type) (t : topologyType X) (x y : X)
    (p : pathType X t x y) : BasedPath X := @BasedPath.mk X t x y p
noncomputable def endpoints (a b : realType) : Endpoints := @Endpoints.mk a b
noncomputable def reversePath {X : Type} (t : topologyType X) (x y : X)
    (p : pathType X t x y) : pathType X t y x := @Path.symm X t x y p
noncomputable def reverse (X : carrierType) (P : BasedPath X) : BasedPath X :=
  @makePath X P.topology P.finish P.start
    (@reversePath X P.topology P.start P.finish P.path)
noncomputable def ordered (I : Endpoints) : conditionType := less I.lower I.upper
noncomputable def shift (I : Endpoints) (s : realType) : Endpoints :=
  @endpoints (add I.lower s) (add I.upper s)
def constructorStatement : Prop := ∀ (a b : realType),
  let I : Endpoints := @endpoints a b
  both (equal I.lower a) (equal I.upper b)
def shiftStatement : Prop := ∀ (I : Endpoints) (s : realType), ordered I → ordered (shift I s)
def pathStatement : Prop := ∀ (X : carrierType) (P : BasedPath X),
  @Exists (pathType X P.topology P.start P.finish) (fun p => equal p P.path)
def reverseStatement : Prop := ∀ (X : carrierType) (P : BasedPath X), equal (reverse X (reverse X P)) P
def functionStatement : Prop := ∀ (f : realType → realType) (x : realType),
  let P : ScalarMap := scalarMap f
  equal (P.map x) (f x)
def dimensionStatement : Prop := ∀ (V : SizedVector),
  @Exists (vectorType V.size realType) (fun v => equal v V.vector)
noncomputable def nativeIdentity (I : Endpoints) : Endpoints := I
def computedStatement : Prop := ∀ (a b : realType), equal a a
def authoredProjectionStatement : Prop := ∀ (I : Endpoints) (s : realType), equal (add I.lower s) (add I.lower s)
def opaqueStatement : Prop := ∀ (I : Endpoints), equal (@nativeIdentity I).lower I.lower
def computedDependentStatement : Prop := ∀ (X : carrierType) (P : BasedPath X), equal P.path P.path
end BundleOracle
'''
checks=[]
for oracle,key in mapping.items():checks.append(f'same_target {key} {oracle}')
for oracle,key,fields in [('BundleOracle.BasedPath',pkey,['topology','start','finish','path']),
                          ('BundleOracle.Endpoints',ikey,['lower','upper']),
                          ('BundleOracle.ScalarMap',skey,['map']),
                          ('BundleOracle.SizedVector',vkey,['size','vector'])]:
    for field in ['mk',*fields]:checks.append(f'same_target {key}.{field} {oracle}.{field}')
for actual,expected_name in [('endpoint_constructor','constructorStatement'),
    ('shifting_endpoints_preserves_order','shiftStatement'),
    ('bundled_path_has_its_declared_endpoints','pathStatement'),
    ('reversing_a_bundled_path_twice','reverseStatement'),
    ('function_field_application','functionStatement'),('vector_field_dimensions','dimensionStatement'),
    ('computed_constructor_projection','computedStatement'),('authored_record_projection','authoredProjectionStatement'),
    ('opaque_record_projection','opaqueStatement'),('computed_dependent_field','computedDependentStatement')]:
    checks.append(f'same_target CleanStatements.{actual} BundleOracle.{expected_name}')
proofs=f'''
namespace BundleProofs
theorem endpoint_constructor : CleanStatements.endpoint_constructor := by
  intro a b
  exact ⟨rfl,rfl⟩
theorem shifting_endpoints_preserves_order : CleanStatements.shifting_endpoints_preserves_order := by
  intro I s h
  change I.lower+s < I.upper+s
  exact add_lt_add_right h s
theorem bundled_path_has_its_declared_endpoints : CleanStatements.bundled_path_has_its_declared_endpoints := by
  intro X P
  exact ⟨P.path,rfl⟩
theorem reversing_a_bundled_path_twice : CleanStatements.reversing_a_bundled_path_twice := by
  intro X P
  change {keys['reversed bundle']} X ({keys['reversed bundle']} X P) = P
  cases P
  simp [{keys['reversed bundle']}, {keys['based path']}, {rkey}, Path.symm_symm]
theorem function_field_application : CleanStatements.function_field_application := by
  intro f x
  rfl
theorem vector_field_dimensions : CleanStatements.vector_field_dimensions := by
  intro V
  exact ⟨V.vector,rfl⟩
theorem computed_constructor_projection : CleanStatements.computed_constructor_projection := by
  intro a b
  rfl
theorem authored_record_projection : CleanStatements.authored_record_projection := by
  intro I s
  rfl
theorem opaque_record_projection : CleanStatements.opaque_record_projection := by
  intro I
  rfl
theorem computed_dependent_field : CleanStatements.computed_dependent_field := by
  intro X P
  rfl
end BundleProofs
'''
path=here/'BundlesVerified.lean';path.write_text(source+comparison+expected+'\n'.join(checks)+'\n'+proofs)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print(f'{len(checks)} canonical record/constructor/projection/definition/statement checks and ten proofs passed.')

# generated: gpt-6 2026-11-06 role=assisted; LLM-authored portions; see PROVENANCE.md
