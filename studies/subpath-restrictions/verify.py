# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
from pathlib import Path
import sys,subprocess,os,re
ROOT=Path(__file__).resolve().parents[2];here=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
e=Environment();rs=load_document(here/'Statements.clean',e)
f=lambda n:e.data['functions'][n]['lean'].split()[0]
s=lean(rs,e,['Lean']);(here/'Generated.lean').write_text(s);(here/'Statements.tex').write_text(latex(rs,e))
names={k:f(v) for k,v in [('SOURCES','subpath sources preserved'),('TARGETS','subpath targets preserved'),('ZIG','zigzag shape'),('DIRECTIONS','subpath directions'),('VERTEX','subpath vertex'),('EDGE','subpath edge'),('INCLUSION','subpath shape map'),('CTOR','shape map'),('PULL','pull back diagram')]}
names.update({k:f(v) for k,v in [('OFFSET','offset vertex'),('WIDEN','widen vertex'),('TRANSPORT','transport vertex'),('ASSOC','natural sum association'),('ADVANCE','advance bound'),('SYM','equality symmetry'),('RESTRICT','restricted zigzag')]})
names.update({k:f(v) for k,v in [('ARROW','pull back arrow'),('COMPOSE','module composition'),('MTRANSPORT','module family transport')]})
names['SHAPE']=e.structures['DiagramShape']['key']
names.update(SHAPEMAP=e.structures['DiagramShapeMap']['key'],DIAGRAM=e.structures['ModuleDiagram']['key'])
expected='''
namespace NamedSubpathOracle
noncomputable def offset (a m : ℕ) (v : Fin m) : Fin (a+m) := Fin.natAdd a v
noncomputable def widen (n m : ℕ) (h : m ≤ n) (v : Fin m) : Fin n := Fin.castLE h v
noncomputable def transport (n m : ℕ) (h : n = m) (v : Fin n) : Fin m := Fin.cast h v
noncomputable def association (a b c : ℕ) : (a+b)+c = a+(b+c) := Nat.add_assoc a b c
noncomputable def advance (a b c : ℕ) (h : a ≤ b) : a+c ≤ b+c := Nat.add_le_add_right h c
noncomputable def edge (n a m : ℕ) (h : a+m ≤ n) (e : Fin m) : Fin n := WIDEN n (a+m) h (OFFSET a m e)
noncomputable def vertex (n a m : ℕ) (h : a+m ≤ n) (v : Fin (m+1)) : Fin (n+1) :=
 WIDEN (n+1) ((a+m)+1) (ADVANCE (a+m) n 1 h)
  (TRANSPORT (a+(m+1)) ((a+m)+1) (@SYM ℕ ((a+m)+1) (a+(m+1)) (ASSOC a m 1)) (OFFSET a (m+1) v))
noncomputable def directions (n a m : ℕ) (h : a+m ≤ n) (d : Fin n → Bool) : Fin m → Bool := fun e => d (EDGE n a m h e)
def sources (n a m : ℕ) (h : a+m ≤ n) (d : Fin n → Bool) : Prop :=
 ∀ e : Fin m, VERTEX n a m h ((ZIG m (DIRECTIONS n a m h d)).source e) = (ZIG n d).source (EDGE n a m h e)
def targets (n a m : ℕ) (h : a+m ≤ n) (d : Fin n → Bool) : Prop :=
 ∀ e : Fin m, VERTEX n a m h ((ZIG m (DIRECTIONS n a m h d)).target e) = (ZIG n d).target (EDGE n a m h e)
noncomputable def inclusion (n a m : ℕ) (h : a+m ≤ n) (d : Fin n → Bool)
 (hs : SOURCES n a m h d) (ht : TARGETS n a m h d) :
 SHAPEMAP (Fin (m+1)) (Fin m) (Fin (n+1)) (Fin n) (ZIG m (DIRECTIONS n a m h d)) (ZIG n d) :=
 CTOR (Fin (m+1)) (Fin m) (Fin (n+1)) (Fin n) (ZIG m (DIRECTIONS n a m h d)) (ZIG n d)
  (fun v => VERTEX n a m h v) (fun e => EDGE n a m h e) hs ht
noncomputable def restriction {K : Type} (field : Field K)
 (n a m : ℕ) (h : a+m ≤ n) (d : Fin n → Bool)
 (hs : SOURCES n a m h d) (ht : TARGETS n a m h d)
 (Z : DIAGRAM K field (Fin (n+1)) (Fin n) (ZIG n d)) :
 DIAGRAM K field (Fin (m+1)) (Fin m) (ZIG m (DIRECTIONS n a m h d)) :=
 @PULL K (Fin (m+1)) (Fin m) (Fin (n+1)) (Fin n) field
  (ZIG m (DIRECTIONS n a m h d)) (ZIG n d) (INCLUSION n a m h d hs ht) Z
def assumed : Prop := ∀ (n a m : ℕ) (h : a+m ≤ n) (d : Fin n → Bool)
 (hs : SOURCES n a m h d) (ht : TARGETS n a m h d),
 ∃ i : SHAPEMAP (Fin (m+1)) (Fin m) (Fin (n+1)) (Fin n) (ZIG m (DIRECTIONS n a m h d)) (ZIG n d),
 ∀ v : Fin (m+1), i.vertices v = VERTEX n a m h v
def sourceStatement : Prop := ∀ (n a m : ℕ) (h : a+m ≤ n) (d : Fin n → Bool), SOURCES n a m h d
def targetStatement : Prop := ∀ (n a m : ℕ) (h : a+m ≤ n) (d : Fin n → Bool), TARGETS n a m h d
def existsStatement : Prop := ∀ (n a m : ℕ) (h : a+m ≤ n) (d : Fin n → Bool),
 ∃ i : SHAPEMAP (Fin (m+1)) (Fin m) (Fin (n+1)) (Fin n) (ZIG m (DIRECTIONS n a m h d)) (ZIG n d),
 ∀ v : Fin (m+1), i.vertices v = VERTEX n a m h v
def objectStatement : Prop := ∀ (K : Type) (field : Field K)
 (n a m : ℕ) (h : a+m ≤ n) (d : Fin n → Bool)
 (hs : SOURCES n a m h d) (ht : TARGETS n a m h d)
 (Z : DIAGRAM K field (Fin (n+1)) (Fin n) (ZIG n d)) (v : Fin (m+1)),
 (@RESTRICT K field n a m h d hs ht Z).object v = Z.object (VERTEX n a m h v)
noncomputable def pullbackArrow {K V E W F : Type} (field : Field K)
 (Q : SHAPE V E) (R : SHAPE W F) (f : SHAPEMAP V E W F Q R)
 (M : DIAGRAM K field W F R) (a : E) :=
 @COMPOSE K field
  (M.object (f.vertices (Q.source a))) (M.object (R.target (f.edges a))) (M.object (f.vertices (Q.target a)))
  (@COMPOSE K field
   (M.object (f.vertices (Q.source a))) (M.object (R.source (f.edges a))) (M.object (R.target (f.edges a)))
   (@MTRANSPORT K W field M.object (f.vertices (Q.source a)) (R.source (f.edges a)) (f.sources a)) (M.arrow (f.edges a)))
  (@MTRANSPORT K W field M.object (R.target (f.edges a)) (f.vertices (Q.target a))
   (@SYM W (f.vertices (Q.target a)) (R.target (f.edges a)) (f.targets a)))
def arrowStatement : Prop := ∀ (K : Type) (field : Field K)
 (n a m : ℕ) (h : a+m ≤ n) (d : Fin n → Bool)
 (hs : SOURCES n a m h d) (ht : TARGETS n a m h d)
 (Z : DIAGRAM K field (Fin (n+1)) (Fin n) (ZIG n d)) (e : Fin m),
 let Q := ZIG m (DIRECTIONS n a m h d)
 let R := ZIG n d
 let i := INCLUSION n a m h d hs ht
 (@RESTRICT K field n a m h d hs ht Z).arrow e =
 @ARROW K (Fin (m+1)) (Fin m) (Fin (n+1)) (Fin n) field Q R i Z e
end NamedSubpathOracle
'''
expected=re.sub(r'\b('+'|'.join(names)+r')\b',lambda m:names[m[0]],expected)
comparison='\nopen Lean Elab Command\nprivate def canonicalName (n : Name) : Name := Id.run do\n\n  match n with\n  | .str p s => return .str (canonicalName p) s\n  | .num p i => return .num (canonicalName p) i\n  | .anonymous => return .anonymous\nprivate def canonical : Expr → Expr\n  | .const n u => .const (canonicalName n) u\n  | .lam _ t b i => .lam Name.anonymous (canonical t) (canonical b) i\n  | .forallE _ t b i => .forallE Name.anonymous (canonical t) (canonical b) i\n  | .letE _ t v b n => .letE Name.anonymous (canonical t) (canonical v) (canonical b) n\n  | .app f a => .app (canonical f) (canonical a)\n  | .mdata _ b => canonical b\n  | .proj n i b => .proj (canonicalName n) i (canonical b)\n  | e => e\nelab "same_target " a:ident b:ident : command => do\n  let env ← getEnv\n  let some x := env.find? a.getId | throwError "Missing actual target"\n  let some y := env.find? b.getId | throwError "Missing expected target"\n  unless x.levelParams == y.levelParams && Expr.equal (canonical x.type) (canonical y.type) do\n    throwError "Canonical type differs: {a} vs {b}"\n  match x,y with\n  | .defnInfo x,.defnInfo y =>\n    unless Expr.equal (canonical x.value) (canonical y.value) do throwError "Canonical body differs"\n  | .thmInfo x,.thmInfo y =>\n    unless Expr.equal (canonical x.value) (canonical y.value) do throwError "Canonical proof differs"\n  | .ctorInfo x,.ctorInfo y =>\n    unless x.numParams == y.numParams && x.numFields == y.numFields && x.cidx == y.cidx &&\n      canonicalName x.induct == canonicalName y.induct do throwError "Constructor differs"\n  | .inductInfo x,.inductInfo y =>\n    unless x.numParams == y.numParams && x.numIndices == y.numIndices &&\n      x.isRec == y.isRec && x.ctors.map canonicalName == y.ctors.map canonicalName do throwError "Record differs"\n  | _,_ => throwError "Unexpected declaration kinds"\n'
pairs=[(f('subpath shape map'),'inclusion'),(f('restricted zigzag'),'restriction'),('CleanStatements.assumed_subpath_inclusion','assumed')]
pairs += [(f(n),o) for n,o in [('offset vertex','offset'),('widen vertex','widen'),('transport vertex','transport'),('natural sum association','association'),('advance bound','advance'),('subpath edge','edge'),('subpath vertex','vertex'),('subpath directions','directions'),('subpath sources preserved','sources'),('subpath targets preserved','targets')]]
pairs += [('CleanStatements.'+n,o) for n,o in [('subpath_sources','sourceStatement'),('subpath_targets','targetStatement'),('subpath_inclusion_exists','existsStatement'),('restricted_zigzag_object','objectStatement')]]
pairs += [(f('pull back arrow'),'pullbackArrow'),('CleanStatements.restricted_zigzag_arrow','arrowStatement')]
s+=expected+comparison+'\n'.join('same_target '+a+' NamedSubpathOracle.'+b for a,b in pairs)+'\n'
s+='theorem assumed_subpath : CleanStatements.assumed_subpath_inclusion := by\n intro n a m h d hs ht\n exact ⟨'+f('subpath shape map')+' n a m h d hs ht, fun v => rfl⟩\n'
unfold=', '.join(f(n) for n in ['subpath sources preserved','subpath targets preserved','subpath vertex','subpath edge','subpath directions','zigzag shape','shape','diagram shape','select value','left vertex','right vertex','widen vertex','offset vertex','transport vertex'])
for n in ['sources','targets']:
 s+='\ntheorem subpath_'+n+'_proof : CleanStatements.subpath_'+n+' := by\n intro n a m h d e\n simp only ['+unfold+']\n split <;> simp_all [Fin.ext_iff, Nat.add_assoc]\n'
s+='\ntheorem subpath_inclusion_proof : CleanStatements.subpath_inclusion_exists := by\n intro n a m h d\n exact ⟨'+f('subpath shape map')+' n a m h d (subpath_sources_proof n a m h d) (subpath_targets_proof n a m h d), fun v => rfl⟩\n'
s+='\ntheorem restricted_object_proof : CleanStatements.restricted_zigzag_object := by\n intro K field n a m h d hs ht Z v\n rfl\n'
s+='\ntheorem restricted_arrow_proof : CleanStatements.restricted_zigzag_arrow := by\n intro K field n a m h d hs ht Z e\n rfl\n'
p=(here/'Verified.lean');p.write_text(s)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Nineteen exact subpath targets and six proofs passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
