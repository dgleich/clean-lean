# generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md
"""Exact native declaration oracles; not higher-carrier elaboration coverage."""
from pathlib import Path
import ast,os,subprocess,sys
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment
from cleanlang.modules import type_declaration
env=Environment()
for name,k,body in [('Small',0,'Type'),('Large',1,'Type 1'),('Higher',2,'Type 2')]:
 type_declaration('Type '+name+'():',[f'Universe: {k+1}',f'Classifies: {k}',
  'Means: '+body,'Render latex: C'],env)
comparison=next(ast.literal_eval(n.value) for n in ast.parse((ROOT/'tools/check_basic_targets.py').read_text()).body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='COMPARISON' for t in n.targets))
# Handwritten oracles intentionally do not derive their levels from metadata.
expected='''
abbrev expectedSmall : Type 1 := Type
abbrev expectedLarge : Type 2 := Type 1
abbrev expectedHigher : Type 3 := Type 2
'''
source='-- generated: gpt-6 2026-11-10 role=assisted; see PROVENANCE.md\nimport Lean\n'+''.join(env.notation_definitions.values())+expected+comparison
source+='\n'.join('same_basic_target '+env.data['types'][name]['native_binding']+' expected'+name for name in ('Small','Large','Higher'))+'\n'
source+='\n-- generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md\n'
path=Path(__file__).with_name('MetadataTargets.lean');path.write_text(source)
subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
print('Three exact classifier declaration targets passed; carrier elaboration remains pending.')

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md
