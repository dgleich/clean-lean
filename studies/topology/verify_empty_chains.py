# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Empty-space singular chains and the actual empty-relative chain inclusion."""
from pathlib import Path
import ast,os,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean
from cleanlang.modules import load_document
HERE=Path(__file__).resolve().parent
env=Environment();results=load_document(HERE/'EmptyChains.clean',env)
source=lean(results,env,['Lean']);(HERE/'EmptyChains.lean').write_text(source)
f=lambda n:env.data['functions'][n]['native_binding']
t=lambda n:env.data['types'][n]['native_binding']
mapping={k:t(n) for k,n in [('TYPE','Type'),('FIELD','FieldStructure'),('SPACE','TopologicalSpace'),('CHAIN','ModuleChainComplex'),('PROP','Proposition')]}
mapping.update({k:env.structures[n]['key'] for k,n in [('THEORY','HomologyTheory'),('PAIR','TopologicalPair')]})
mapping.update({k:f(n) for k,n in [('EMPTY','empty space'),('ZEROC','zero chain complex'),('EMPTYREL','empty relative part'),('SUBSPACE','subspace'),('CHAINS','singular chains'),('INCLUSION','pair chain inclusion'),('ZERO','zero chain map'),('EQ','equal')]})
oracles='''
namespace EmptyChainOracle
noncomputable def empty (X : SPACE) : PROP := IsEmpty X.carrier
noncomputable def zero {K : Type} (field : FIELD K) (C : CHAIN K field) : PROP :=
 letI : Field K := field
 CategoryTheory.Limits.IsZero C
noncomputable def relative (X : SPACE) (Q : PAIR X) : PROP := EMPTY (SUBSPACE X Q.relative)
def chainsStatement : Prop := ∀ (K : TYPE) (field : FIELD K) (H : THEORY K field) (X : SPACE), EMPTY X → ZEROC field (CHAINS field H X)
def inclusionStatement : Prop := ∀ (K : TYPE) (field : FIELD K) (H : THEORY K field) (X : SPACE) (Q : PAIR X),
 EMPTYREL X Q → EQ (INCLUSION field H X Q) (ZERO field (CHAINS field H (SUBSPACE X Q.relative)) (CHAINS field H (SUBSPACE X Q.ambient)))
end EmptyChainOracle

open CategoryTheory CategoryTheory.Limits

-- Mathematical proof, using the standard coproduct and chain comparison.
theorem singularChainsEmpty (K : Type) [Field K] (R : ModuleCat.{0} K)
 (X : TopCat.{0}) [IsEmpty X] :
 IsZero (((AlgebraicTopology.singularChainComplexFunctor (ModuleCat.{0} K)).obj R).obj X) := by
 have hz : IsZero (∐ fun _ : X => R) := by
  apply (IsZero.iff_id_eq_zero _).2
  apply Sigma.hom_ext
  intro x
  exact isEmptyElim x
 have ha : IsZero (ChainComplex.alternatingConst.obj (∐ fun _ : X => R)) := by
  apply (IsZero.iff_id_eq_zero _).2
  apply HomologicalComplex.hom_ext
  intro n
  exact hz.eq_of_src _ _
 exact ha.of_iso (AlgebraicTopology.singularChainComplexFunctorIsoOfTotallyDisconnectedSpace (ModuleCat.{0} K) R X)

theorem emptySpaceChains : CleanStatements.empty_space_has_zero_singular_chains := by
 intro K field H X empty
 letI : Field K := field
 letI : IsEmpty X := empty
 exact singularChainsEmpty K H.coefficients X

theorem emptyRelativeInclusion : CleanStatements.empty_relative_part_has_zero_chain_inclusion := by
 intro K field H X Q empty
 letI : Field K := field
 have hz := emptySpaceChains K field H (SUBSPACE X Q.relative) empty
 exact hz.eq_of_src _ _
'''
for key,value in mapping.items():oracles=re.sub(r'\b'+key+r'\b',value,oracles)
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
pairs=[(f(n),'EmptyChainOracle.'+o) for n,o in [('empty space','empty'),('zero chain complex','zero'),('empty relative part','relative')]]
pairs += [('CleanStatements.'+n,'EmptyChainOracle.'+o) for n,o in [('empty_space_has_zero_singular_chains','chainsStatement'),('empty_relative_part_has_zero_chain_inclusion','inclusionStatement')]]
path=HERE/'EmptyChainsVerified.lean';path.write_text(source+oracles+comparison+'\n'.join('same_basic_target '+a+' '+b for a,b in pairs)+'\n')
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Five exact targets and two Clean-result proofs (plus the generic empty-chain lemma) passed; compatible cokernel transport remains pending.')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
