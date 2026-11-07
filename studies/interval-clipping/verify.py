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
names={k:f(v) for k,v in [('MIN','natural minimum'),('BOUND','bounded vertex'),('MINBOUND','minimum left bound'),('NUMBER','vertex number'),('CLIP','clipped vertex'),('SURVIVE','surviving interval labels'),('VERTEX','subpath vertex'),('AT','interval labels at'),('SET','set of')]}
names['LABELS']=e.structures['IntervalLabels']['key']
expected='\nnamespace ClippingOracle\nnoncomputable def minimum (a b : ℕ) : ℕ := min a b\nnoncomputable def minimumBound (a b : ℕ) : MIN a b ≤ a := Nat.min_le_left a b\nnoncomputable def bounded (n k : ℕ) (h : k ≤ n) : Fin (n+1) := Fin.mk k (Nat.lt_succ_of_le h)\nnoncomputable def clip (n a m : ℕ) (v : Fin (n+1)) : Fin (m+1) :=\n BOUND m (MIN m (NUMBER (n+1) v - a)) (MINBOUND m (NUMBER (n+1) v - a))\nnoncomputable def surviving (I : Type) (n a m : ℕ) (L : LABELS I n) : Set I :=\n SET (fun i => NUMBER (n+1) (L.lower i) ≤ a+m ∧ a ≤ NUMBER (n+1) (L.upper i))\ndef retractionStatement : Prop := ∀ (n a m : ℕ) (h : a+m ≤ n) (v : Fin (m+1)),\n CLIP n a m (VERTEX n a m h v) = v\ndef monotoneStatement : Prop := ∀ (n a m : ℕ) (u v : Fin (n+1)) (_ : u ≤ v),\n CLIP n a m u ≤ CLIP n a m v\ndef supportStatement : Prop := ∀ (I : Type) (n a m : ℕ) (h : a+m ≤ n)\n (L : LABELS I n) (i : I) (_ : i ∈ SURVIVE I n a m L) (v : Fin (m+1)),\n (CLIP n a m (L.lower i) ≤ v ∧ v ≤ CLIP n a m (L.upper i)) ↔\n i ∈ AT I n L (VERTEX n a m h v)\nend ClippingOracle\n'
names.update({k:f(v) for k,v in [('NUMORDER','vertex order numbers'),('SUBORDER','subtraction preserves order'),('MINORDER','minimum preserves order'),('BOUNDORDER','bounded vertices ordered'),('CLIPORDER','clipped vertices ordered'),('SELECT','selected value'),('MAKE','interval labels')]})
expected=expected.replace('end ClippingOracle', r"""
noncomputable def numberOrder (n : ℕ) (u v : Fin n) (h : u ≤ v) : NUMBER n u ≤ NUMBER n v := h
noncomputable def subtractionOrder (a u v : ℕ) (h : u ≤ v) : u-a ≤ v-a := Nat.sub_le_sub_right h a
noncomputable def minimumOrder (m u v : ℕ) (h : u ≤ v) : MIN m u ≤ MIN m v := min_le_min_left m h
noncomputable def boundedOrder (n k l : ℕ) (hk : k ≤ n) (hl : l ≤ n) (h : k ≤ l) :
 BOUND n k hk ≤ BOUND n l hl := h
noncomputable def clippingOrder (n a m : ℕ) (u v : Fin (n+1)) (h : u ≤ v) :
 CLIP n a m u ≤ CLIP n a m v :=
 BOUNDORDER m (MIN m (NUMBER (n+1) u-a)) (MIN m (NUMBER (n+1) v-a))
   (MINBOUND m (NUMBER (n+1) u-a)) (MINBOUND m (NUMBER (n+1) v-a))
   (MINORDER m (NUMBER (n+1) u-a) (NUMBER (n+1) v-a)
     (SUBORDER a (NUMBER (n+1) u) (NUMBER (n+1) v) (NUMORDER (n+1) u v h)))
noncomputable def restrictedLabels (I : Type) (n a m : ℕ) (L : LABELS I n) :
 LABELS {i : I // i ∈ SURVIVE I n a m L} m :=
 MAKE {i : I // i ∈ SURVIVE I n a m L} m
   (fun j => CLIP n a m (L.lower (SELECT (SURVIVE I n a m L) j)))
   (fun j => CLIP n a m (L.upper (SELECT (SURVIVE I n a m L) j)))
   (fun j => CLIPORDER n a m
     (L.lower (SELECT (SURVIVE I n a m L) j))
     (L.upper (SELECT (SURVIVE I n a m L) j))
     (L.ordered (SELECT (SURVIVE I n a m L) j)))
end ClippingOracle
""")
for a,b in names.items():expected=re.sub(r"\b"+a+r"\b",b,expected)
comparison='\nopen Lean Elab Command\nprivate def canonicalName (n : Name) : Name := Id.run do\n\n  match n with\n  | .str p s => return .str (canonicalName p) s\n  | .num p i => return .num (canonicalName p) i\n  | .anonymous => return .anonymous\nprivate def canonical : Expr → Expr\n  | .const n u => .const (canonicalName n) u\n  | .lam _ t b i => .lam Name.anonymous (canonical t) (canonical b) i\n  | .forallE _ t b i => .forallE Name.anonymous (canonical t) (canonical b) i\n  | .letE _ t v b n => .letE Name.anonymous (canonical t) (canonical v) (canonical b) n\n  | .app f a => .app (canonical f) (canonical a)\n  | .mdata _ b => canonical b\n  | .proj n i b => .proj (canonicalName n) i (canonical b)\n  | e => e\nelab "same_target " a:ident b:ident : command => do\n  let env ← getEnv\n  let some x := env.find? a.getId | throwError "Missing actual target"\n  let some y := env.find? b.getId | throwError "Missing expected target"\n  unless x.levelParams == y.levelParams && Expr.equal (canonical x.type) (canonical y.type) do\n    throwError "Canonical type differs: {a} vs {b}"\n  match x,y with\n  | .defnInfo x,.defnInfo y =>\n    unless Expr.equal (canonical x.value) (canonical y.value) do throwError "Canonical body differs"\n  | .thmInfo x,.thmInfo y =>\n    unless Expr.equal (canonical x.value) (canonical y.value) do throwError "Canonical proof differs"\n  | .ctorInfo x,.ctorInfo y =>\n    unless x.numParams == y.numParams && x.numFields == y.numFields && x.cidx == y.cidx &&\n      canonicalName x.induct == canonicalName y.induct do throwError "Constructor differs"\n  | .inductInfo x,.inductInfo y =>\n    unless x.numParams == y.numParams && x.numIndices == y.numIndices &&\n      x.isRec == y.isRec && x.ctors.map canonicalName == y.ctors.map canonicalName do throwError "Record differs"\n  | _,_ => throwError "Unexpected declaration kinds"\n'
pairs=[(f(n),o) for n,o in [('natural minimum','minimum'),('minimum left bound','minimumBound'),('bounded vertex','bounded'),('clipped vertex','clip'),('surviving interval labels','surviving')]]
pairs += [('CleanStatements.'+n,o) for n,o in [('clipped_subpath_vertex','retractionStatement'),('clipping_preserves_order','monotoneStatement'),('clipped_interval_support','supportStatement')]]
pairs += [(f(n),o) for n,o in [('vertex order numbers','numberOrder'),('subtraction preserves order','subtractionOrder'),('minimum preserves order','minimumOrder'),('bounded vertices ordered','boundedOrder'),('clipped vertices ordered','clippingOrder'),('restricted interval labels','restrictedLabels')]]
s+=expected+comparison+'\n'.join('same_target '+a+' ClippingOracle.'+b for a,b in pairs)+'\n'
keys=[f(n) for n in ['clipped vertex','natural minimum','bounded vertex','vertex number','subpath vertex','widen vertex','transport vertex','offset vertex','surviving interval labels','interval labels at','set of']]
unfold=', '.join(keys)

s+='\ntheorem clipping_retraction : CleanStatements.clipped_subpath_vertex := by\n unfold CleanStatements.clipped_subpath_vertex\n intro n a m h v\n apply Fin.ext\n simp only ['+unfold+']\n try simp only [Fin.val_mk, Fin.coe_natAdd, Fin.coe_castLE, Fin.coe_cast] at *\n omega\n'
s+='\ntheorem clipping_monotone : CleanStatements.clipping_preserves_order := by\n unfold CleanStatements.clipping_preserves_order\n intro n a m u v ordered\n simp only ['+unfold+', Fin.le_iff_val_le_val] at *\n omega\n'
s+='\ntheorem clipping_support : CleanStatements.clipped_interval_support := by\n unfold CleanStatements.clipped_interval_support\n intro I n a m h L i survives v\n simp only ['+unfold+', Set.mem_setOf_eq, Fin.le_iff_val_le_val] at *\n try simp only [Fin.val_mk, Fin.coe_natAdd, Fin.coe_castLE, Fin.coe_cast] at *\n omega\n'
p=here/'Verified.lean';p.write_text(s)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Fourteen exact clipping targets and three proofs passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
