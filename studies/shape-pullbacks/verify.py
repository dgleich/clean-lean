# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
from pathlib import Path
import os,sys,re,subprocess
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
here=Path(__file__).resolve().parent
e=Environment();rs=load_document(here/'Statements.clean',e)
source=lean(rs,e,['Lean']);(here/'Generated.lean').write_text(source);(here/'Statements.tex').write_text(latex(rs,e))
f=lambda name:e.data['functions'][name]['lean'].split()[0]
names={k:e.structures[n]['key'] for k,n in [('SHAPE','DiagramShape'),('DIAGRAM','ModuleDiagram'),('SMAP','DiagramShapeMap')]}
names.update({k:f(n) for k,n in [('SHORTID','shape identity'),('SHORTCOMP','compose shapes'),('SHORTPULL','pull back diagram'),('SYM','equality symmetry'),('TRANS','equality transitivity'),('CONGR','equality congruence'),('REFL','equality reflexivity'),('TRANSPORT','module family transport'),('IDENTITY','identity shape map'),('COMPOSITE','composite shape map'),('PULL','diagram pullback'),('MK','shape map'),('MD','module diagram'),('MID','module identity'),('COMP','module composition')]})
def fill(s):return re.sub(r'\b('+'|'.join(names)+r')\b',lambda m:names[m[0]],s)
expected=fill(r'''
namespace ShapeOracle
noncomputable def symmetry {T : Type} (x y : T) (h : x = y) : y = x := Eq.symm h
noncomputable def transitivity {T : Type} (x y z : T) (h : x = y) (k : y = z) : x = z := Eq.trans h k
structure Map (V E W F : Type) (Q : SHAPE V E) (R : SHAPE W F) : Type where
 vertices : V → W
 edges : E → F
 sources : (a : E) → vertices (Q.source a) = R.source (edges a)
 targets : (a : E) → vertices (Q.target a) = R.target (edges a)
noncomputable def identity (V E : Type) (Q : SHAPE V E) : SMAP V E V E Q Q :=
 @MK V E V E Q Q (fun v : V => v) (fun a : E => a)
  (fun a : E => @REFL V (Q.source a)) (fun a : E => @REFL V (Q.target a))
noncomputable def composite (V E W F U J : Type) (Q : SHAPE V E) (R : SHAPE W F) (S : SHAPE U J)
 (f : SMAP V E W F Q R) (g : SMAP W F U J R S) : SMAP V E U J Q S :=
 @MK V E U J Q S (fun v : V => g.vertices (f.vertices v)) (fun a : E => g.edges (f.edges a))
 (fun a : E => @TRANS U (g.vertices (f.vertices (Q.source a))) (g.vertices (R.source (f.edges a))) (S.source (g.edges (f.edges a)))
  (@CONGR W U g.vertices (f.vertices (Q.source a)) (R.source (f.edges a)) (f.sources a)) (g.sources (f.edges a)))
 (fun a : E => @TRANS U (g.vertices (f.vertices (Q.target a))) (g.vertices (R.target (f.edges a))) (S.target (g.edges (f.edges a)))
  (@CONGR W U g.vertices (f.vertices (Q.target a)) (R.target (f.edges a)) (f.targets a)) (g.targets (f.edges a)))
noncomputable def transport {K T : Type} (field : Field K) (M : T → @ModuleCat.{0,0} K field.toRing)
 (x y : T) (h : x = y) : @ModuleCat.Hom K field.toRing (M x) (M y) :=
 @CategoryTheory.eqToHom (@ModuleCat.{0,0} K field.toRing) (@ModuleCat.moduleCategory.{0,0} K field.toRing).toCategoryStruct (M x) (M y) (congrArg M h)
noncomputable def pullback (K : Type) (field : Field K) (V E W F : Type) (Q : SHAPE V E) (R : SHAPE W F)
 (f : SMAP V E W F Q R) (M : DIAGRAM K field W F R) : DIAGRAM K field V E Q :=
 @MD K field V E Q (fun v : V => M.object (f.vertices v))
 (fun a : E => @COMP K field (M.object (f.vertices (Q.source a))) (M.object (R.target (f.edges a))) (M.object (f.vertices (Q.target a)))
  (@COMP K field (M.object (f.vertices (Q.source a))) (M.object (R.source (f.edges a))) (M.object (R.target (f.edges a)))
   (@TRANSPORT K W field M.object (f.vertices (Q.source a)) (R.source (f.edges a)) (f.sources a)) (M.arrow (f.edges a)))
  (@TRANSPORT K W field M.object (R.target (f.edges a)) (f.vertices (Q.target a))
   (@SYM W (f.vertices (Q.target a)) (R.target (f.edges a)) (f.targets a))))
noncomputable def shortIdentity {V E : Type} (Q : SHAPE V E) : SMAP V E V E Q Q := @IDENTITY V E Q
noncomputable def shortComposite {V E W F U J : Type} (Q : SHAPE V E) (R : SHAPE W F) (S : SHAPE U J)
 (f : SMAP V E W F Q R) (g : SMAP W F U J R S) : SMAP V E U J Q S := @COMPOSITE V E W F U J Q R S f g
noncomputable def shortPullback {K V E W F : Type} (field : Field K) (Q : SHAPE V E) (R : SHAPE W F)
 (f : SMAP V E W F Q R) (M : DIAGRAM K field W F R) : DIAGRAM K field V E Q := @PULL K field V E W F Q R f M
def identityVertex : Prop := ∀ (V E : Type) (Q : SHAPE V E) (v : V), (@SHORTID V E Q).vertices v = v
def compositeVertex : Prop := ∀ (V E W F : Type) (Q : SHAPE V E) (R : SHAPE W F) (f : SMAP V E W F Q R)
 (U J : Type) (S : SHAPE U J) (g : SMAP W F U J R S) (v : V),
 (@SHORTCOMP V E W F U J Q R S f g).vertices v = g.vertices (f.vertices v)
def compositeEdge : Prop := ∀ (V E W F : Type) (Q : SHAPE V E) (R : SHAPE W F) (f : SMAP V E W F Q R)
 (U J : Type) (S : SHAPE U J) (g : SMAP W F U J R S) (a : E),
 (@SHORTCOMP V E W F U J Q R S f g).edges a = g.edges (f.edges a)
def leftIdentity : Prop := ∀ (V E W F : Type) (Q : SHAPE V E) (R : SHAPE W F) (f : SMAP V E W F Q R),
 @SHORTCOMP V E V E W F Q Q R (@SHORTID V E Q) f = f
def rightIdentity : Prop := ∀ (V E W F : Type) (Q : SHAPE V E) (R : SHAPE W F) (f : SMAP V E W F Q R),
 @SHORTCOMP V E W F W F Q R R f (@SHORTID W F R) = f
def transportRefl : Prop := ∀ (K T : Type) (field : Field K) (M : T → @ModuleCat.{0,0} K field.toRing) (x : T),
 @TRANSPORT K T field M x x (@REFL T x) = @MID K field (M x)
def pullbackObject : Prop := ∀ (K : Type) (field : Field K) (V E W F : Type) (Q : SHAPE V E) (R : SHAPE W F)
 (f : SMAP V E W F Q R) (M : DIAGRAM K field W F R) (v : V),
 (@SHORTPULL K V E W F field Q R f M).object v = M.object (f.vertices v)
def identityPullback : Prop := ∀ (K : Type) (field : Field K) (V E : Type) (Q : SHAPE V E) (M : DIAGRAM K field V E Q),
 @SHORTPULL K V E V E field Q Q (@SHORTID V E Q) M = M
def compositePullback : Prop := ∀ (K : Type) (field : Field K) (V E W F U J : Type)
 (Q : SHAPE V E) (R : SHAPE W F) (S : SHAPE U J) (f : SMAP V E W F Q R) (g : SMAP W F U J R S)
 (M : DIAGRAM K field U J S),
 @SHORTPULL K V E U J field Q S (@SHORTCOMP V E W F U J Q R S f g) M =
 @SHORTPULL K V E W F field Q R f (@SHORTPULL K W F U J field R S g M)
end ShapeOracle
''')
mapping={'ShapeOracle.Map':names['SMAP'],'ShapeOracle.Map.mk':names['SMAP']+'.mk'}
for field in ['vertices','edges','sources','targets']:mapping['ShapeOracle.Map.'+field]=names['SMAP']+'.'+field
checks=[(v,k) for k,v in mapping.items()]
for name,oracle in [('shape identity','shortIdentity'),('compose shapes','shortComposite'),('pull back diagram','shortPullback'),('equality symmetry','symmetry'),('equality transitivity','transitivity'),('module family transport','transport'),('identity shape map','identity'),('composite shape map','composite'),('diagram pullback','pullback')]:checks.append((f(name),'ShapeOracle.'+oracle))
for name,oracle in [('identity_shape_vertex','identityVertex'),('composite_shape_vertex','compositeVertex'),('composite_shape_edge','compositeEdge'),('shape_left_identity','leftIdentity'),('shape_right_identity','rightIdentity'),('module_transport_reflexivity','transportRefl'),('pullback_vertex_module','pullbackObject'),('identity_pullback','identityPullback'),('composite_pullback','compositePullback')]:checks.append(('CleanStatements.'+name,'ShapeOracle.'+oracle))
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
proof=fill(r'''
namespace ShapeProofs
theorem identityVertex : CleanStatements.identity_shape_vertex := by
 intro V E Q v
 rfl
theorem compositeVertex : CleanStatements.composite_shape_vertex := by
 intro V E W F Q R f U J S g v
 rfl
theorem compositeEdge : CleanStatements.composite_shape_edge := by
 intro V E W F Q R f U J S g a
 rfl
theorem leftIdentity : CleanStatements.shape_left_identity := by
 intro V E W F Q R f
 rfl
theorem rightIdentity : CleanStatements.shape_right_identity := by
 intro V E W F Q R f
 rfl
theorem transportRefl : CleanStatements.module_transport_reflexivity := by
 intro K T field M x
 rfl
theorem pullbackObject : CleanStatements.pullback_vertex_module := by
 intro K field V E W F Q R f M v
 rfl
theorem identityPullback : CleanStatements.identity_pullback := by
 intro K field V E Q M
 rfl
theorem compositePullback : CleanStatements.composite_pullback := by
 intro K field V E W F U J Q R S f g M
 letI : Field K := field
 dsimp only [SHORTPULL, SHORTCOMP, PULL, COMPOSITE, MK, MD]
 congr 1
 funext a
 dsimp only [COMP, TRANSPORT, TRANS, SYM, CONGR]
 simp only [CategoryTheory.Category.assoc, CategoryTheory.eqToHom_trans_assoc, CategoryTheory.eqToHom_trans]
end ShapeProofs
''')
p=here/'Verified.lean';p.write_text(source+expected+comparison+'\n'.join('same_target '+a+' '+b for a,b in checks)+proof)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print(str(len(checks))+' exact shape/pullback targets and nine proofs passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
