# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
from pathlib import Path
import os,subprocess,sys,re
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
here=Path(__file__).resolve().parent
e=Environment();rs=load_document(here/'Statements.clean',e)
source=lean(rs,e,['Lean']);(here/'Generated.lean').write_text(source);(here/'Statements.tex').write_text(latex(rs,e))
f=lambda n:e.data['functions'][n]['lean'].split()[0]
substitutions={key:e.structures[name]['key'] for key,name in
 [('SHAPE','DiagramShape'),('DIAGRAM','ModuleDiagram'),('LABELS','IntervalLabels'),('BASIS','IntervalBasis')]}
substitutions.update({key:f(name) for key,name in [
 ('MKSHAPE','diagram shape'),('SHAPEFN','shape'),('MKDIAGRAM','module diagram'),
 ('CONSTANT','constant module diagram'),('CONSTANTSHORT','constant diagram'),
 ('MID','module identity'),('SELECT','select value'),('LEFT','left vertex'),('RIGHT','right vertex'),
 ('ZSHAPE','zigzag shape'),('ZCONSTANT','constant zigzag'),('ORDER','ordered interval endpoints'),
 ('AT','interval labels at'),('SRC','zigzag source'),('TGT','zigzag target'),('BV','module basis vector'),
 ('ZERO','module zero'),('EVAL','evaluate map'),('VAL','selected value'),('REALIZES','interval vectors realize bases'),
 ('VANISHES','interval vectors vanish'),('COMPATIBLE','interval vectors compatible'),('MAPVALUE','module map value'),
 ('VECTOR','interval basis vector'),('TRUE','true value'),('FALSE','false value')]})
def fill(s):return re.sub(r'\b('+'|'.join(substitutions)+r')\b',lambda m:substitutions[m[0]],s)
# These abbreviations are expanded before elaboration: they are not extra Lean constants
# and are not extracted from generated target types.
macros={
 'MOD':'(@ModuleCat.{0,0} K field.toRing)',
 'HOMCD':'(@ModuleCat.Hom K field.toRing C D)',
 'ZTYPE':'DIAGRAM K field (Fin (n+1)) (Fin n) (@ZSHAPE n d)',
 'VECTORS':'(v : Fin (n+1)) → I → (Z.object v).carrier',
 'BASES':'(v : Fin (n+1)) → @Module.Basis {i : I // i ∈ @AT I n L v} K (Z.object v).carrier field.toSemiring (Z.object v).isAddCommGroup.toAddCommMonoid (Z.object v).isModule'}
def expand(s):
 for key,value in macros.items():s=re.sub(r'\b'+key+r'\b',lambda _:value,s)
 return fill(s)
expected=expand(r"""
namespace ZigzagOracle
structure Shape (V E : Type) where
 source : E → V
 target : E → V
structure Diagram (K : Type) (field : Field K) (V E : Type) (Q : SHAPE V E) : Type 1 where
 object : V → MOD
 arrow : (a : E) → @ModuleCat.Hom K field.toRing (object (Q.source a)) (object (Q.target a))
structure Labels (I : Type) (n : ℕ) where
 lower : I → Fin (n+1)
 upper : I → Fin (n+1)
 ordered : @ORDER I n lower upper
structure Basis (K : Type) (field : Field K) (n : ℕ) (d : Fin n → Bool)
 (Z : ZTYPE) (I : Type) (L : LABELS I n) where
 vectors : VECTORS
 basis : BASES
 realizes : @REALIZES K field n d Z I L vectors basis
 vanishes : @VANISHES K field n d Z I L vectors
 compatible : @COMPATIBLE K field n d Z I L vectors
noncomputable def shape {V E : Type} (source target : E → V) : SHAPE V E :=
 @MKSHAPE V E source target
noncomputable def constant (K : Type) (field : Field K) (V E : Type)
 (Q : SHAPE V E) (M : MOD) : DIAGRAM K field V E Q :=
 @MKDIAGRAM K field V E Q (fun _ : V => M) (fun _ : E => @MID K field M)
noncomputable def constantShort {K V E : Type} (field : Field K)
 (Q : SHAPE V E) (M : MOD) : DIAGRAM K field V E Q := @CONSTANT K field V E Q M
noncomputable def select {T : Type} (b : Bool) (x y : T) : T := if b then x else y
noncomputable def left (n : ℕ) (a : Fin n) : Fin (n+1) := a.castSucc
noncomputable def right (n : ℕ) (a : Fin n) : Fin (n+1) := a.succ
noncomputable def shapeZ (n : ℕ) (d : Fin n → Bool) : SHAPE (Fin (n+1)) (Fin n) :=
 @SHAPEFN (Fin (n+1)) (Fin n)
  (fun a : Fin n => @SELECT (Fin (n+1)) (d a) (@LEFT n a) (@RIGHT n a))
  (fun a : Fin n => @SELECT (Fin (n+1)) (d a) (@RIGHT n a) (@LEFT n a))
noncomputable def constantZ (K : Type) (field : Field K) (n : ℕ)
 (d : Fin n → Bool) (M : MOD) : ZTYPE :=
 @CONSTANTSHORT K (Fin (n+1)) (Fin n) field (@ZSHAPE n d) M
noncomputable def ordered (I : Type) (n : ℕ) (lower upper : I → Fin (n+1)) : Prop :=
 ∀ i : I, lower i ≤ upper i
noncomputable def activeLabels (I : Type) (n : ℕ) (L : LABELS I n) (v : Fin (n+1)) : Set I :=
 @SETOF I (fun i : I => L.lower i ≤ v ∧ v ≤ L.upper i)
noncomputable def source (n : ℕ) (d : Fin n → Bool) (a : Fin n) : Fin (n+1) :=
 (@ZSHAPE n d).source a
noncomputable def target (n : ℕ) (d : Fin n → Bool) (a : Fin n) : Fin (n+1) :=
 (@ZSHAPE n d).target a
noncomputable def basisVector {K I : Type} (field : Field K) (M : MOD)
 (b : @Module.Basis I K M.carrier field.toSemiring M.isAddCommGroup.toAddCommMonoid M.isModule)
 (i : I) : M.carrier := (letI : Field K := field; b i)
noncomputable def zero {K : Type} (field : Field K) (M : MOD) : M.carrier :=
 @Zero.zero M.carrier M.isAddCommGroup.toZero
noncomputable def realizes (K : Type) (field : Field K) (n : ℕ) (d : Fin n → Bool)
 (Z : ZTYPE) (I : Type) (L : LABELS I n) (vectors : VECTORS) (basis : BASES) : Prop :=
 ∀ (v : Fin (n+1)) (j : {i : I // i ∈ @AT I n L v}),
 @BV K {i : I // i ∈ @AT I n L v} field (Z.object v) (basis v) j =
 @EVAL I (Z.object v).carrier (vectors v) (@VAL I (@AT I n L v) j)
noncomputable def vanishes (K : Type) (field : Field K) (n : ℕ) (d : Fin n → Bool)
 (Z : ZTYPE) (I : Type) (L : LABELS I n) (vectors : VECTORS) : Prop :=
 ∀ (v : Fin (n+1)) (i : I), ¬ i ∈ @AT I n L v →
 @EVAL I (Z.object v).carrier (vectors v) i = @ZERO K field (Z.object v)
noncomputable def compatible (K : Type) (field : Field K) (n : ℕ) (d : Fin n → Bool)
 (Z : ZTYPE) (I : Type) (L : LABELS I n) (vectors : VECTORS) : Prop :=
 ∀ (a : Fin n) (i : I), i ∈ @AT I n L (@SRC n d a) →
 @MAPVALUE K field (Z.object (@SRC n d a)) (Z.object (@TGT n d a)) (Z.arrow a)
  (@EVAL I (Z.object (@SRC n d a)).carrier (vectors (@SRC n d a)) i) =
 @EVAL I (Z.object (@TGT n d a)).carrier (vectors (@TGT n d a)) i
noncomputable def vector {K : Type} (field : Field K) (n : ℕ) (d : Fin n → Bool)
 (Z : ZTYPE) (I : Type) (L : LABELS I n) (B : BASIS K field n d Z I L)
 (v : Fin (n+1)) (i : I) : (Z.object v).carrier :=
 @EVAL I (Z.object v).carrier (B.vectors v) i

def forwardStatement : Prop := ∀ (n : ℕ) (d : Fin n → Bool) (a : Fin n), d a = @TRUE →
 @SRC n d a = @LEFT n a ∧ @TGT n d a = @RIGHT n a
def backwardStatement : Prop := ∀ (n : ℕ) (d : Fin n → Bool) (a : Fin n), d a = @FALSE →
 @SRC n d a = @RIGHT n a ∧ @TGT n d a = @LEFT n a
def constantStatement : Prop := ∀ (K : Type) (field : Field K) (V E : Type)
 (Q : SHAPE V E) (M : MOD) (a : E),
 (@CONSTANT K field V E Q M).arrow a = @MID K field M
def supportStatement : Prop := ∀ (K : Type) (field : Field K) (n : ℕ) (d : Fin n → Bool)
 (Z : ZTYPE) (I : Type) (L : LABELS I n) (B : BASIS K field n d Z I L)
 (v : Fin (n+1)) (i : I),
 @VECTOR K field n d Z I L B v i ≠ @ZERO K field (Z.object v) ↔ i ∈ @AT I n L v
def edgeStatement : Prop := ∀ (K : Type) (field : Field K) (n : ℕ) (d : Fin n → Bool)
 (Z : ZTYPE) (I : Type) (L : LABELS I n) (B : BASIS K field n d Z I L)
 (a : Fin n) (i : I), i ∈ @AT I n L (@SRC n d a) →
 @MAPVALUE K field (Z.object (@SRC n d a)) (Z.object (@TGT n d a)) (Z.arrow a)
  (@VECTOR K field n d Z I L B (@SRC n d a) i) =
 @VECTOR K field n d Z I L B (@TGT n d a) i
def existsStatement : Prop := ∀ (K : Type) (field : Field K) (n : ℕ) (d : Fin n → Bool)
 (M : MOD) (I : Type)
 (b : @Module.Basis I K M.carrier field.toSemiring M.isAddCommGroup.toAddCommMonoid M.isModule),
 ∃ L : LABELS I n, ∃ B : BASIS K field n d (@ZCONSTANT K field n d M) I L,
 ∀ (v : Fin (n+1)) (i : I), i ∈ @AT I n L v
end ZigzagOracle
""")
# Add one explicitly named foundational wrapper to the substitution table.
expected=expected.replace('SETOF',f('set of'))
mapping={}
for actual,oracle,fields in [
 ('DiagramShape','Shape',['source','target']),('ModuleDiagram','Diagram',['object','arrow']),
 ('IntervalLabels','Labels',['lower','upper','ordered']),
 ('IntervalBasis','Basis',['vectors','basis','realizes','vanishes','compatible'])]:
 mapping['ZigzagOracle.'+oracle]=e.structures[actual]['key']
checks=[]
for oracle,actual in mapping.items():
 checks.append((actual,oracle));checks.append((actual+'.mk',oracle+'.mk'))
for actual,oracle,fields in [
 ('DiagramShape','Shape',['source','target']),('ModuleDiagram','Diagram',['object','arrow']),
 ('IntervalLabels','Labels',['lower','upper','ordered']),
 ('IntervalBasis','Basis',['vectors','basis','realizes','vanishes','compatible'])]:
 for field in fields:checks.append((e.structures[actual]['key']+'.'+field,'ZigzagOracle.'+oracle+'.'+field))
for name,oracle in [('shape','shape'),('constant module diagram','constant'),('constant diagram','constantShort'),
 ('select value','select'),('left vertex','left'),('right vertex','right'),('zigzag shape','shapeZ'),
 ('constant zigzag','constantZ'),('ordered interval endpoints','ordered'),('interval labels at','activeLabels'),
 ('zigzag source','source'),('zigzag target','target'),('module basis vector','basisVector'),('module zero','zero'),
 ('interval vectors realize bases','realizes'),('interval vectors vanish','vanishes'),
 ('interval vectors compatible','compatible'),('interval basis vector','vector')]:
 checks.append((f(name),'ZigzagOracle.'+oracle))
for actual,oracle in [('forward_edge','forwardStatement'),('backward_edge','backwardStatement'),
 ('constant_diagram_arrow','constantStatement'),('interval_vector_support','supportStatement'),
 ('interval_edge_action','edgeStatement'),('constant_zigzag_has_interval_basis','existsStatement')]:
 checks.append(('CleanStatements.'+actual,'ZigzagOracle.'+oracle))

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
    unless Expr.equal (canonical x.value) (canonical y.value) do throwError "Canonical body differs"
  | .thmInfo x,.thmInfo y =>
    unless Expr.equal (canonical x.value) (canonical y.value) do throwError "Canonical proof differs"
  | .ctorInfo x,.ctorInfo y =>
    unless x.numParams == y.numParams && x.numFields == y.numFields && x.cidx == y.cidx &&
      canonicalName x.induct == canonicalName y.induct do throwError "Constructor differs"
  | .inductInfo x,.inductInfo y =>
    unless x.numParams == y.numParams && x.numIndices == y.numIndices &&
      x.isRec == y.isRec && x.ctors.map canonicalName == y.ctors.map canonicalName do throwError "Record differs"
  | _,_ => throwError "Unexpected declaration kinds"
'''
proof=expand(r"""
set_option maxHeartbeats 2000000
namespace ZigzagProofs
 theorem forward : CleanStatements.forward_edge := by
  intro n d a h
  change d a = true at h
  change (if d a then a.castSucc else a.succ) = a.castSucc ∧
    (if d a then a.succ else a.castSucc) = a.succ
  simp [h]
 theorem backward : CleanStatements.backward_edge := by
  intro n d a h
  change d a = false at h
  change (if d a then a.castSucc else a.succ) = a.succ ∧
    (if d a then a.succ else a.castSucc) = a.castSucc
  simp [h]
 theorem constantArrow : CleanStatements.constant_diagram_arrow := by
  intro K field V E Q M a
  rfl
 theorem support : CleanStatements.interval_vector_support := by
  intro K field n d Z I L B v i
  letI : Field K := field
  change B.vectors v i ≠ 0 ↔ i ∈ @AT I n L v
  constructor
  · intro nonzero
    by_contra absent
    exact nonzero (B.vanishes v i absent)
  · intro active zero
    have h := B.realizes v ⟨i,active⟩
    change (B.basis v) ⟨i,active⟩ = B.vectors v i at h
    exact (B.basis v).ne_zero ⟨i,active⟩ (h.trans zero)
 theorem edge : CleanStatements.interval_edge_action := by
  intro K field n d Z I L B a i active
  exact B.compatible a i active
 theorem constantBasis : CleanStatements.constant_zigzag_has_interval_basis := by
  intro K field n d M I b
  letI : Field K := field
  let Z := @ZCONSTANT K field n d M
  let L : LABELS I n := {
    lower := fun _ => 0
    upper := fun _ => Fin.last n
    ordered := by intro i; exact Fin.zero_le _ }
  have allActive (v : Fin (n+1)) (i : I) : i ∈ @AT I n L v := by
    change (0 : Fin (n+1)) ≤ v ∧ v ≤ Fin.last n
    exact ⟨Fin.zero_le v, Fin.le_last v⟩
  let equiv (v : Fin (n+1)) : I ≃ {i : I // i ∈ @AT I n L v} := {
    toFun := fun i => ⟨i,allActive v i⟩
    invFun := Subtype.val
    left_inv := fun _ => rfl
    right_inv := by intro i; cases i; rfl }
  let B : BASIS K field n d Z I L := {
    vectors := fun _ i => b i
    basis := fun v => b.reindex (equiv v)
    realizes := by
      intro v j
      change (b.reindex (equiv v)) j = b j.val
      exact b.reindex_apply (equiv v) j
    vanishes := by
      intro v i absent
      exact False.elim (absent (allActive v i))
    compatible := by
      intro a i active
      rfl }
  exact ⟨L,B,allActive⟩
end ZigzagProofs
""")
p=here/'Verified.lean';p.write_text(source+expected+comparison+'\n'.join('same_target '+a+' '+b for a,b in checks)+proof)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print(str(len(checks))+' exact diagram/basis targets and six proofs passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
