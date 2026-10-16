"""Experimental explicit definition modules; no implicit import search path."""
import hashlib
import re
from pathlib import Path
from .core import CleanError, ID, parse, split, textext


def load_document(path, reg):
    """Load one document into its own environment, preserving source line numbers."""
    active, visited = [], set()
    reg.notation_definitions = {}
    reg.lean_imports = []

    def notation(header, fields, origin):
        m = re.fullmatch(r'Notation\s+('+ID+r'(?: +'+ID+r')*)\((.*?)\):', header, re.I)
        if not m:
            raise CleanError(f'{origin}: invalid Notation header')
        name, params = m[1], split(m[2])
        if len(set(params)) != len(params) or any(not re.fullmatch(ID, p) for p in params):
            raise CleanError(f'{origin}: invalid or duplicate parameters')
        if name in reg.data['functions']:
            raise CleanError(f'{origin}: duplicate visible name: {name}')
        types, values = {}, {}
        for field in fields:
            decl = re.fullmatch(r'Let\s+('+ID+r'):\s*(.+)', field, re.I)
            if decl:
                if decl[1] in types or decl[1] not in params:
                    raise CleanError(f'{origin}: duplicate or unknown parameter: {decl[1]}')
                types[decl[1]] = reg.type(decl[2], env={})
                continue
            item = re.fullmatch(r'(Returns|Means|Render):\s*(.+)', field, re.I)
            if not item or item[1].lower() in values:
                raise CleanError(f'{origin}: unknown or duplicate notation field: {field}')
            values[item[1].lower()] = item[2]
        if list(types) != params or set(values) != {'returns', 'means', 'render'}:
            raise CleanError(f'{origin}: declare parameters in header order and provide Returns, Means, Render')
        result = reg.type(values['returns'], env={})
        # Render text is escaped; only named placeholders are interpreted.
        parts = re.split(r'(\{[^{}]*\})', values['render'])
        latex = ''
        for part in parts:
            if part.startswith('{') and part.endswith('}'):
                key = part[1:-1]
                if key not in params:
                    raise CleanError(f'{origin}: unknown Render parameter: {key}')
                latex += '{'+str(params.index(key))+'}'
            else:
                if '{' in part or '}' in part:
                    raise CleanError(f'{origin}: unmatched Render brace')
                latex += r'\text{{'+textext(part).replace('{','{{').replace('}','}}')+'}}' if part else ''
        signature = ' '.join(f'({p} : {reg.render_type(types[p], "lean")})' for p in params)
        body = f'{signature} : {reg.render_type(result, "lean")} :=\n  {values["means"]}'
        key = 'cleanNotation_'+hashlib.sha256((name+body).encode()).hexdigest()[:20]
        reg.notation_definitions[key] = f'def {key} {body}\n'
        reg.data['functions'][name] = {
            'params': [str(types[p]) for p in params], 'returns': str(result),
            'lean': key+''.join(' ({'+str(i)+'})' for i in range(len(params))), 'latex': latex,
        }

    def visit(file, root=False):
        file = file.resolve()
        if file in active:
            raise CleanError('Cyclic Clean import: '+' -> '.join(str(p) for p in active+[file]))
        if file in visited:
            return ''
        active.append(file)
        lines = file.read_text().splitlines()
        output = ['']*len(lines)
        i, started = 0, False
        while i < len(lines):
            line = lines[i]
            if not line.strip() or line.lstrip().startswith('#'):
                i += 1
                continue
            origin = f'{file}:{i+1}'
            if '\t' in line:
                raise CleanError(f'{origin}: tabs are not allowed')
            lean_import = re.fullmatch(r'Import Lean\s+([A-Za-z_][\w.]*)', line, re.I)
            clean_import = re.fullmatch(r'Import\s+"([^"\n]+)"', line, re.I)
            is_notation = re.match(r'Notation\s', line, re.I)
            if lean_import or clean_import or is_notation:
                if started:
                    raise CleanError(f'{origin}: imports and notation must precede results')
                if lean_import:
                    if lean_import[1] not in reg.lean_imports:
                        reg.lean_imports.append(lean_import[1])
                elif clean_import:
                    visit(file.parent / clean_import[1])
                else:
                    fields = []
                    j = i+1
                    while j < len(lines) and (not lines[j].strip() or lines[j][0].isspace() or lines[j].lstrip().startswith('#')):
                        field = lines[j]
                        if field.strip() and not field.lstrip().startswith('#'):
                            if '\t' in field or not field.startswith('    ') or field.startswith('     '):
                                raise CleanError(f'{file}:{j+1}: notation fields require four spaces')
                            fields.append(field.strip())
                        j += 1
                    notation(line, fields, origin)
                    i = j
                    continue
            else:
                if not root:
                    raise CleanError(f'{origin}: imported modules may contain only imports and notation')
                started = True
                output[i] = line
            i += 1
        active.pop()
        visited.add(file)
        return '\n'.join(output)

    text = visit(Path(path), root=True)
    return parse(text, reg)
