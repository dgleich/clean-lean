# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
from pathlib import Path
import ast,os,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
e=Environment();rs=load_document(HERE/'Generic.clean',e)
f=lambda n:e.data['functions'][n]['lean'].split()[0]
s=lean(rs,e,['Lean']);(HERE/'GenericGenerated.lean').write_text(s);(HERE/'Generic.tex').write_text(latex(rs,e))
keys={k:f(v) for k,v in [('VALUE','element value'),('MEMBER','element membership'),('ELEMENT','element from membership'),('GFORWARD','restrict element'),('GBACKWARD','restore element'),('GEQUIV','subtype restriction equivalence'),('EQUIV','equivalence'),('EVAL','equivalence forward')]}
keys['SUPPORT']=e.structures['SubtypeRestrictionSupport']['key']
# These literal oracles are independently authored, shared with the interval check.
module=ast.parse((HERE/'verify.py').read_text())
expected=next(ast.literal_eval(n.value) for n in module.body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='expected' for t in n.targets))
primitive=expected[expected.index('noncomputable def value'):expected.index('noncomputable def old')]
generic=expected[expected.index('noncomputable def supportConstructor'):expected.index('noncomputable def forward')]
expected='\nnamespace GenericOracle\n'+primitive+generic+r'''
def leftStatement : Prop := ∀ (A : Type) (S T : Set A) (U : Set {i : A // i ∈ S})
 (support : SUPPORT A S T U) (x : {i : A // i ∈ T}), GBACKWARD A S T U support (GFORWARD A S T U support x) = x
def rightStatement : Prop := ∀ (A : Type) (S T : Set A) (U : Set {i : A // i ∈ S})
 (support : SUPPORT A S T U) (y : {j : {i : A // i ∈ S} // j ∈ U}), GFORWARD A S T U support (GBACKWARD A S T U support y) = y
def existsStatement : Prop := ∀ (A : Type) (S T : Set A) (U : Set {i : A // i ∈ S})
 (support : SUPPORT A S T U), ∃ e : {i : A // i ∈ T} ≃ {j : {i : A // i ∈ S} // j ∈ U},
 ∀ x : {i : A // i ∈ T}, VALUE S (VALUE U (EVAL e x)) = VALUE T x
end GenericOracle
'''
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
pairs=[(f(n),v) for n,v in [('element value','value'),('element membership','member'),('element from membership','element'),('restrict element','genericForward'),('restore element','genericBackward'),('subtype restriction equivalence','genericEquivalence')]]
pairs += [('CleanStatements.'+n,v) for n,v in [('restore_a_restricted_element','leftStatement'),('restrict_a_restored_element','rightStatement'),('supported_sets_correspond','existsStatement')]]
extra=expected+comparison+'\n'.join('same_basic_target '+a+' GenericOracle.'+b for a,b in pairs)+'\n'+r'''
run_cmd do
 let env ← Lean.getEnv
 let some a := env.find? `SUPPORT.mk | throwError "Missing support constructor"
 let some b := env.find? `GenericOracle.supportConstructor | throwError "Missing expected constructor"
 unless a.levelParams == b.levelParams && Lean.Expr.equal (canonical a.type) (canonical b.type) do
   throwError "Support constructor type differs"
theorem restore_generic_checked : CleanStatements.restore_a_restricted_element := by
 intro A S T U support x
 apply Subtype.ext
 rfl
theorem restrict_generic_checked : CleanStatements.restrict_a_restored_element := by
 intro A S T U support y
 apply Subtype.ext
 apply Subtype.ext
 rfl
theorem supported_sets_checked : CleanStatements.supported_sets_correspond := by
 intro A S T U support
 refine ⟨GEQUIV A S T U support
   (fun x => restore_generic_checked A S T U support x)
   (fun y => restrict_generic_checked A S T U support y), ?_⟩
 intro x
 rfl
'''
for key,value in keys.items():extra=re.sub(r'\b'+key+r'\b',value,extra)
p=HERE/'GenericVerified.lean';p.write_text(s+extra)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
print('Ten exact generic-subtype checks and three proofs passed')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
