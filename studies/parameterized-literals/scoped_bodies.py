# generated: gpt-6 2026-11-11 role=assisted; see PROVENANCE.md
"""Prepare scoped binder rows and retain a joint solver's selected body.

This is an experimental boundary, not automatic nested-binder enumeration.
"""
from cleanlang.core import Expr,Expressions,texid
from cleanlang.dependent_functions import fresh_bound,DependentFunctionType,substitute
from constraint_model import Incomplete,NoSolution
from clean_rows import Builder

class ScopedBody:
    def __init__(self,env,scope,tree,expected=None,*,path,limit=4096,binder_ids=None):
        if tree[0] not in ('Lambda','Forall','Exists'):raise Incomplete('Scoped body requires a binder')
        if limit<=1:raise Incomplete('Scoped body resource limit exceeded')
        kind,name,source,body=tree
        if name in scope or any(name in env.data[k] for k in ('functions','types','aliases')):
            raise Incomplete('Scoped binder must be fresh')
        domain=env.type(source,scope,phrases=False)
        local=Expr(fresh_bound(env,scope),texid(name),domain,tree=['Local',name])
        inner={**scope,name:local};body_expected=None
        if kind in ('Forall','Exists'):
            body_expected=env.type('Proposition')
            if expected is not None and expected!=body_expected:raise NoSolution('Quantifier result mismatch')
        elif expected is not None:
            if not env.is_function_type(expected) or len(expected.args)!=2:raise NoSolution('Lambda result is not callable')
            if domain!=expected.args[0]:raise NoSolution('Lambda domain mismatch')
            body_expected=(substitute(expected.codomain,{expected.binder:local},env,inner)
                           if isinstance(expected,DependentFunctionType) else expected.args[1])
        self.env=env;self.scope=scope;self.tree=tree;self.expected=expected
        self.body_expected=body_expected
        identity=('binder',tuple(path))
        if identity in (binder_ids or {}).values():raise Incomplete('Scoped binder identity must be fresh')
        ids={**(binder_ids or {}),name:identity}
        self.builder=Builder(env,inner,limit-1,binder_ids=ids,binder_path=tuple(path)+(3,),row_namespace=tuple(path)+(3,))

    def rows(self):
        """Expose checked body alternatives without defaulting or selecting."""
        return self.builder.rows(self.tree[3],self.body_expected)

    def retain(self,selection):
        """Rebind the retained body by re-elaborating the complete source binder."""
        body=self.builder.retain_selected(self.tree[3],selection,self.body_expected)
        return Expressions(self.env,self.scope).elaborate([*self.tree[:3],body.tree],self.expected)

# generated: gpt-6 2026-11-11 role=assisted; LLM-authored portions; see PROVENANCE.md
