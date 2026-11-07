# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Check native interval support separately from the expensive full translation.

Old/new active sets are independent Lean oracles from verify.py, not yet compared
with their full generated Clean targets by this check.
"""
from pathlib import Path
import ast,os,re,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,lean
from cleanlang.modules import load_module

def render_arithmetic(e):
    """Instantiate independent proof templates with this environment's bindings."""
    f=lambda name:e.data['functions'][name]['lean'].split()[0]
    module=ast.parse((HERE/'verify.py').read_text())
    literals={t.id:ast.literal_eval(n.value) for n in module.body if isinstance(n,ast.Assign) and isinstance(n.value,ast.Constant) and isinstance(n.value.value,str) for t in n.targets if isinstance(t,ast.Name)}
    expected=literals['expected'];proofs=literals['proofs']
    sets=expected[expected.index('noncomputable def old'):expected.index('noncomputable def supportConstructor')]
    existence=expected[expected.index('def existsStatement'):expected.index('end ActiveOracle')]
    support=proofs[proofs.index('private theorem support_exists'):proofs.index('theorem active_labels_checked')]
    extra='\nnamespace Arithmetic\n'+sets+existence+support+r'''
theorem active_labels_exist : existsStatement := by
 intro I n a m h L v
 obtain ⟨support⟩ := support_exists I n a m h L v
 refine ⟨GEQUIV I (SUR I n a m L) (OLD I n a m h L v) (NEW I n a m L v) support ?_ ?_, ?_⟩
 · intro x
   apply Subtype.ext
   rfl
 · intro y
   apply Subtype.ext
   apply Subtype.ext
   rfl
 · intro x
   rfl
end Arithmetic
'''
    keys={k:f(v) for k,v in [('VALUE','element value'),('ELEMENT','element from membership'),('SUR','surviving interval labels'),('AT','interval labels at'),('RESTRICT','restricted interval labels'),('SUBPATH','subpath vertex'),('EVAL','equivalence forward'),('GEQUIV','subtype restriction equivalence')]}
    keys.update(OLD='Arithmetic.old',NEW='Arithmetic.new',LABELS=e.structures['IntervalLabels']['key'],SUPPORT=e.structures['SubtypeRestrictionSupport']['key'])
    unfold=[keys['OLD'],keys['NEW']]+[f(n) for n in ['surviving interval labels','interval labels at','set of','restricted interval labels','interval labels','clipped vertex','natural minimum','bounded vertex','vertex number','subpath vertex','offset vertex','widen vertex','transport vertex','selected value','element value','element from membership']]
    extra=extra.replace('UNFOLD',', '.join(unfold+['Set.mem_setOf_eq','Fin.le_iff_val_le_val']))
    extra=extra.replace('SUPPORT I n a m h L v','SUPPORT I (SUR I n a m L) (OLD I n a m h L v) (NEW I n a m L v)')
    for key,value in keys.items():extra=re.sub(r'\b'+key+r'\b',value,extra)
    return extra


if __name__ == '__main__':
    e=Environment()
    for name in ['logic/subtype_restriction.clean','diagrams/interval_clipping.clean']:
        load_module(ROOT/'library'/name,e)
        print('Loaded',name,flush=True)
    s=lean([],e,['Lean'])
    extra=render_arithmetic(e)
    p=HERE/'Arithmetic.lean';p.write_text(s+extra)
    print('Checking arithmetic support and native existence theorem',flush=True)
    subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(p)],cwd=ROOT,check=True)
    print('Arithmetic support and native existence theorem passed; full Clean target comparison remains pending')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
