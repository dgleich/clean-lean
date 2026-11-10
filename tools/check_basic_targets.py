# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Independent identity-statement oracles across legal source variants."""
from pathlib import Path
import os,subprocess,sys,tempfile
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT))
from cleanlang.core import Environment,Type,lean
from cleanlang.modules import load_document

VARIANTS=[
 ('x','Result identity:\n  Attribution: local; identity; original\n  Let x: Real\n  Conclude: x = x\n'),
 ('y','Result identity:\n  Attribution: local; identity; original\n  Let y: Real\n  Conclude: y = y\n'),
 ('x','RESULT identity:\n    ATTRIBUTION: local; identity; original\n    LET x be a Real\n    CONCLUDE:\n      x = x\n'),
 ('x','Result identity:\n   Attribution: local; identity; original\n   Let x: Real -- explicit carrier\n   Conclude: (\n     x = x\n   )\n'),
]
COMPARISON=r'''
open Lean Elab Command
private def canonical : Expr → Expr
  | .lam _ t b i => .lam Name.anonymous (canonical t) (canonical b) i
  | .forallE _ t b i => .forallE Name.anonymous (canonical t) (canonical b) i
  | .letE _ t v b n => .letE Name.anonymous (canonical t) (canonical v) (canonical b) n
  | .app f a => .app (canonical f) (canonical a)
  | .mdata _ b => canonical b
  | .proj n i b => .proj n i (canonical b)
  | e => e
elab "same_basic_target " a:ident b:ident : command => do
  let env ← getEnv
  let some (.defnInfo x) := env.find? a.getId | throwError "Missing actual target"
  let some (.defnInfo y) := env.find? b.getId | throwError "Missing expected target"
  unless x.levelParams == y.levelParams &&
      Expr.equal (canonical x.type) (canonical y.type) &&
      Expr.equal (canonical x.value) (canonical y.value) do
    throwError "Canonical type or value differs"
'''

def source(name,body):
    return f'Import "{ROOT / "library/operators.clean"}"\nSource local:\n  Kind: other\n  Label: Local\n  Title: Independent identity acceptance\n'+body

def generate():
    imports=[];bodies=[];shared=None;real=None;equal=None;proposition=None
    with tempfile.TemporaryDirectory() as td:
        for i,(local,body) in enumerate(VARIANTS):
            p=Path(td)/'Identity.clean';p.write_text(source(local,body))
            env=Environment();results=load_document(p,env)
            assert len(results)==1
            r=results[0]
            assert r.name=='identity'
            assert r.attribution=={'source':'local','reference':'identity','relationship':'original'}
            assert len(r.clauses)==1
            clause=r.clauses[0]
            assert (clause.kind,clause.names,clause.value)==('let',[local],Type('Real'))
            assert r.conclusion.tree==['Operator','=', ['Local',local],['Local',local]]
            assert r.conclusion.type==Type('Proposition')
            assert r.conclusion.operator_binding[0]=='equal'
            text=lean(results,env,['Lean']);lines=text.splitlines()
            for line in lines:
                if line.startswith('import ') and line not in imports:imports.append(line)
            declarations, statements = '\n'.join(
                line for line in lines if not line.startswith('import ')
            ).split('namespace CleanStatements', 1)
            if shared is None:
                shared = declarations
                real = env.data['types']['Real']['native_binding']
                equal = env.data['functions']['equal']['native_binding']
                proposition = env.data['types']['Proposition']['native_binding']
            else:
                assert declarations == shared
                assert env.data['types']['Real']['native_binding'] == real
            bodies.append(f'namespace BasicCase{i}\nnamespace CleanStatements'
                          + statements + f'\nend BasicCase{i}\n')
    target='\n'.join(imports)+'\n'+COMPARISON+shared+'\n'.join(bodies)
    target+='\ndef basic_real_expected : Type := ℝ\n'
    target+=f'same_basic_target {real} basic_real_expected\n'
    target+=f'\ndef basic_proposition_expected : Type := Prop\n'
    target+=f'same_basic_target {proposition} basic_proposition_expected\n'
    target+=f'\nnoncomputable def basic_equal_expected {{T : Type}} (x y : T) : _root_.{proposition} := @Eq.{{1}} T x y\n'
    target+=f'same_basic_target {equal} basic_equal_expected\n'
    target+=f'\ndef basic_expected : Prop := ∀ (x : _root_.{real}), @_root_.{equal} _root_.{real} x x\n'
    for i in range(len(VARIANTS)):
        target+=f'same_basic_target BasicCase{i}.CleanStatements.identity basic_expected\n'
    target+='''
-- Definitional equality must not substitute for canonical structure equality.
def basic_alias : Prop := basic_expected
/-- error: Canonical type or value differs -/
#guard_msgs in
same_basic_target basic_alias basic_expected
'''
    return target

if __name__=='__main__':
    path=ROOT/'generated/BasicAcceptance.lean';path.write_text(generate())
    subprocess.run([os.environ.get('LAKE','lake'),'env','lean',str(path)],cwd=ROOT,check=True)
    print('Four identity trees, four statement targets and three adapter targets passed; alias mismatch rejected')

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
