# generated: gpt-6 2026-11-10 role=assisted; isolated prototype; see PROVENANCE.md
"""Versioned data encoding, not an elaboration or an environment loader."""
import json
from cleanlang.annotations import Annotation
from cleanlang.core import Type,LocalType,ComputedCarrier,ValueIndex,ProofType,Expr,CleanError
from cleanlang.indices import ComputedIndex,DimensionIndex
from cleanlang.proof_types import ProofIndex
from cleanlang.dependent_functions import DependentFunctionType
from cleanlang.binder_keys import ScopedKey

# The schema is explicit: dataclass changes do not silently change version 3.
SCHEMA={
 'Type':(Type,('name','args')),
 'ComputedCarrier':(ComputedCarrier,('name','args','universe','classifier')),
 'LocalType':(LocalType,('name','args','lean','universe','classifier')),
 'ValueIndex':(ValueIndex,('name','lean','tex','comparison')),
 'ComputedIndex':(ComputedIndex,('name','lean','tex','comparison','syntax','resolved')),
 'DimensionIndex':(DimensionIndex,('name','lean','tex','comparison','syntax','resolved')),
 'ProofIndex':(ProofIndex,('name','lean','tex','comparison','syntax','resolved','scope')),
 'ProofType':(ProofType,('name','args')),
 'DependentFunctionType':(DependentFunctionType,('name','args','constructor','binder','bound')),
 'Expr':(Expr,('lean','tex','type','precedence','tree','local_normal','local_expand','inferred_args','checked_args','operator_binding')),
 'ScopedKey':(ScopedKey,('parts',)),
}

def dumps(value):
 active=set()
 def encode(item):
  if type(item) in (str,int,bool) or item is None:return item
  identity=id(item)
  if identity in active:raise CleanError('Bound-tree encoding does not support cycles')
  active.add(identity)
  try:
   if isinstance(item,Annotation):
    return {'tag':'Annotation','source':str(item),'type':encode(item.typ),'names':sorted(item.names)}
   if type(item) is list:return [encode(x) for x in item]
   if type(item) is tuple:return {'tag':'Tuple','items':[encode(x) for x in item]}
   for tag,(cls,names) in SCHEMA.items():
    if type(item) is cls:
     from dataclasses import fields
     if {f.name for f in fields(item)}!=set(names):raise CleanError('Bound-tree schema requires a version change: '+tag)
     return {'tag':tag,'fields':{name:encode(getattr(item,name)) for name in names}}
   raise CleanError('Unsupported bound-tree value: '+type(item).__name__)
  finally:active.remove(identity)
 return json.dumps({'format':'clean-bound-tree','version':3,'value':encode(value)},ensure_ascii=False,sort_keys=True,separators=(',',':'))

def loads(source):
 def pairs(entries):
  result={}
  for key,value in entries:
   if key in result:raise CleanError('Duplicate bound-tree field: '+key)
   result[key]=value
  return result
 def constant(value):raise CleanError('Invalid bound-tree numeric constant: '+value)
 try:document=json.loads(source,object_pairs_hook=pairs,parse_constant=constant)
 except (ValueError,TypeError) as error:raise CleanError('Invalid bound-tree JSON') from error
 if (type(document) is not dict or set(document)!={'format','version','value'} or
     document['format']!='clean-bound-tree' or type(document['version']) is not int or document['version']!=3):
  raise CleanError('Unsupported bound-tree envelope or version')
 def decode(item):
  if type(item) in (str,int,bool) or item is None:return item
  if type(item) is list:return [decode(x) for x in item]
  if type(item) is not dict:raise CleanError('Unsupported bound-tree data')
  tag=item.get('tag')
  if tag=='Tuple':
   if set(item)!={'tag','items'} or type(item['items']) is not list:raise CleanError('Malformed tuple encoding')
   return tuple(decode(x) for x in item['items'])
  if tag=='Annotation':
   if set(item)!={'tag','source','type','names'} or type(item['source']) is not str or type(item['names']) is not list:
    raise CleanError('Malformed annotation encoding')
   names=item['names']
   if any(type(n) is not str for n in names) or names!=sorted(set(names)):raise CleanError('Noncanonical annotation names')
   typ=decode(item['type'])
   if not isinstance(typ,Type):raise CleanError('Annotation requires an encoded type')
   return Annotation(item['source'],typ,names)
  if type(tag) is not str or tag not in SCHEMA:raise CleanError('Unknown bound-tree tag')
  cls,names=SCHEMA[tag]
  if set(item)!={'tag','fields'} or type(item['fields']) is not dict or set(item['fields'])!=set(names):
   raise CleanError('Malformed bound-tree record: '+tag)
  values={name:decode(item['fields'][name]) for name in names}
  if tag in ('Type','LocalType','ProofType','DependentFunctionType'):
   if type(values['name']) is not str or type(values['args']) is not tuple:raise CleanError('Malformed type fields')
  if tag=='ComputedCarrier':
   if (values['name']!='$carrier' or type(values['args']) is not tuple or
       len(values['args'])!=1 or not isinstance(values['args'][0],ValueIndex) or
       type(values['universe']) is not int or values['universe']<0 or
       type(values['classifier']) is not str or not values['classifier']):
    raise CleanError('Malformed computed carrier metadata')
  if tag=='LocalType':
   if (type(values['lean']) is not str or type(values['classifier']) is not str or
       type(values['universe']) is not int or values['universe']<0):
    raise CleanError('Malformed local carrier metadata')
  if tag=='ProofType':
   if values['name']!='$proof' or len(values['args'])!=1 or not isinstance(values['args'][0],ValueIndex):raise CleanError('Malformed proof type')
   return ProofType(values['args'][0])
  if tag=='DependentFunctionType':
   if values['name']!='$dependentFunction' or len(values['args'])!=2 or any(type(values[n]) is not str for n in ('constructor','binder','bound')):
    raise CleanError('Malformed dependent function type')
   return DependentFunctionType(values['constructor'],values['binder'],values['bound'],*values['args'])
  try:return cls(**values)
  except (TypeError,ValueError) as error:raise CleanError('Malformed bound-tree record: '+tag) from error
 return decode(document['value'])

# generated: gpt-6 2026-11-10 role=assisted; LLM-authored portions; see PROVENANCE.md

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
