# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Working-compiler basis transport laws with independent canonical targets."""
from pathlib import Path
import ast,os,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean,latex
from cleanlang.modules import load_document
env=Environment();results=load_document(HERE/'Composition.clean',env)
s=lean(results,env,['Lean'])
(HERE/'Composition.lean').write_text(s)
(HERE/'Composition.tex').write_text(latex(results,env))
t=lambda n:env.data['types'][n]['native_binding']
f=lambda n:env.data['functions'][n]['native_binding']
small=t('Type');field=t('FieldStructure');module=t('CoefficientModule');basis=t('ModuleBasis');equiv=t('Equivalence')
reindex=f('reindex module basis');equal=f('equal');compose=f('compose equivalences');identity=f('identity equivalence');inverse=f('inverse equivalence')
# These expected expressions are authored independently of the generated statements.
oracle=f'''
namespace BasisTransportOracle
def successive : Prop := ∀ (K I J L : {small}) (field : {field} K)
 (M : {module} K field) (b : {basis} K field M I)
 (e : {equiv} I J) (f : {equiv} J L),
 @{equal} ({basis} K field M L)
   (@{reindex} K J L field M (@{reindex} K I J field M b e) f)
   (@{reindex} K I L field M b (@{compose} I J L e f))
def identity : Prop := ∀ (K I : {small}) (field : {field} K)
 (M : {module} K field) (b : {basis} K field M I),
 @{equal} ({basis} K field M I)
   (@{reindex} K I I field M b (@{identity} I)) b
def reverse : Prop := ∀ (K I J : {small}) (field : {field} K)
 (M : {module} K field) (b : {basis} K field M I) (e : {equiv} I J),
 @{equal} ({basis} K field M I)
   (@{reindex} K J I field M (@{reindex} K I J field M b e) (@{inverse} I J e)) b
end BasisTransportOracle
'''
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body
 if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
checks='\n'.join('same_basic_target CleanStatements.'+source+' BasisTransportOracle.'+target for source,target in [
 ('successive_basis_reindexing','successive'),('identity_basis_reindexing','identity'),('reversing_basis_reindexing','reverse')])
proofs=f'''
theorem successive_basis_reindexing_checked : CleanStatements.successive_basis_reindexing := by
 intro K I J L field M b e f
 letI : Field K := field
 change (b.reindex e).reindex f = b.reindex (@{compose} I J L e f)
 apply DFunLike.ext
 intro l
 simp only [Module.Basis.reindex_apply]
 rfl

theorem identity_basis_reindexing_checked : CleanStatements.identity_basis_reindexing := by
 intro K I field M b
 letI : Field K := field
 change b.reindex (@{identity} I) = b
 apply DFunLike.ext
 intro i
 simp only [Module.Basis.reindex_apply]
 rfl

theorem reversing_basis_reindexing_checked : CleanStatements.reversing_basis_reindexing := by
 intro K I J field M b e
 letI : Field K := field
 change (b.reindex e).reindex (@{inverse} I J e) = b
 apply DFunLike.ext
 intro i
 simp only [Module.Basis.reindex_apply]
 exact congrArg b (e.symm_apply_apply i)
'''
path=HERE/'CompositionVerified.lean';path.write_text(s+oracle+comparison+checks+'\n'+proofs)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Three exact basis transport targets and three proofs passed.')

# generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md
