# generated: gpt-6 2026-11-06 role=assisted; see PROVENANCE.md
"""Export the authored topology comparison to GitHub-readable Markdown.

No third-party dependencies. This converter deliberately supports only the report's
HTML vocabulary; new markup must be handled explicitly instead of silently lost.
"""
from dataclasses import dataclass, field
from html.parser import HTMLParser
from pathlib import Path
import argparse
import re

ROOT=Path(__file__).resolve().parents[1]
SOURCE=ROOT/'studies/topology/comparison.html'
DESTINATION=SOURCE.with_suffix('.md')

@dataclass
class Node:
    tag: str
    attrs: dict = field(default_factory=dict)
    children: list = field(default_factory=list)

class Report(HTMLParser):
    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.root=Node('root');self.stack=[self.root]
    def handle_starttag(self,tag,attrs):
        node=Node(tag,dict(attrs));self.stack[-1].children.append(node)
        if tag not in {'meta','link','br','hr'}:self.stack.append(node)
    def handle_endtag(self,tag):
        if self.stack[-1].tag!=tag:raise ValueError('Unbalanced report HTML: '+tag)
        self.stack.pop()
    def handle_data(self,data):self.stack[-1].children.append(data)

def plain(node):
    return node if isinstance(node,str) else ''.join(plain(c) for c in node.children)

class Markdown:
    def __init__(self):self.language='text'
    def render(self,node):
        if isinstance(node,str):return re.sub(r'\s+',' ',node)
        tag=node.tag
        if tag in {'head','style','nav','footer','meta','link'}:return ''
        if tag=='pre':
            body=plain(node).strip('\n')
            fence='`'*max(3,1+max((len(m[0]) for m in re.finditer(r'`+',body)),default=0))
            language=self.language;self.language='text'
            return '\n\n'+fence+language+'\n'+body+'\n'+fence+'\n\n'
        if tag=='table':
            def rows(n):
                if isinstance(n,str):return []
                if n.tag=='tr':return [n]
                return [r for c in n.children for r in rows(c)]
            data=[[self.render(c).strip().replace('|',r'\|') for c in row.children
                   if isinstance(c,Node) and c.tag in {'th','td'}] for row in rows(node)]
            if not data:return ''
            lines=['| '+' | '.join(data[0])+' |','| '+' | '.join(['---']*len(data[0]))+' |']
            lines+=['| '+' | '.join(row)+' |' for row in data[1:]]
            return '\n\n'+'\n'.join(lines)+'\n\n'
        content=''.join(self.render(c) for c in node.children)
        if tag in {'h1','h2','h3'}:
            if tag=='h3':
                self.language='clean' if plain(node).startswith('Clean') else 'lean' if plain(node).startswith('Lean') else 'text'
            return '\n\n'+'#'*int(tag[1])+' '+content.strip()+'\n\n'
        if tag=='p':return '\n\n'+content.strip()+'\n\n'
        if tag=='a':return '['+content+']('+node.attrs['href']+')'
        if tag=='code':return '`'+content+'`'
        if tag in {'strong','b'}:return '**'+content+'**'
        if tag in {'em','i'}:return '*'+content+'*'
        if tag=='br':return '  \n'
        if tag=='hr':return '\n\n---\n\n'
        if tag in {'root','html','body','llm','main','section','article','div','header','span','th','td'}:return content
        raise ValueError('Unsupported report element: '+tag)

def export(source):
    parser=Report();parser.feed(source)
    if len(parser.stack)!=1:raise ValueError('Unclosed HTML elements')
    lines=[];fence=0
    for line in Markdown().render(parser.root).splitlines():
        marker=re.match(r'^(`{3,})',line)
        if marker:
            width=len(marker[1])
            if not fence:fence=width
            elif width>=fence:fence=0
        if not fence and not line.strip() and lines and not lines[-1].strip():continue
        lines.append(line)
    body='\n'.join(lines).strip()
    return (':::llm gpt-6 2026-11-06 role=assisted\n\n'
            '<!-- Generated from comparison.html by tools/comparison_markdown.py. -->\n\n'
            '[Side-by-side HTML version](comparison.html) · [Current study status](README.md)\n\n'+body+'\n\n:::\n')

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--check',action='store_true');args=parser.parse_args()
    output=export(SOURCE.read_text())
    if args.check:
        if not DESTINATION.exists() or DESTINATION.read_text()!=output:raise SystemExit('Stale comparison.md; run tools/comparison_markdown.py')
        print('Comparison Markdown matches the HTML source')
    else:
        DESTINATION.write_text(output);print('Wrote '+str(DESTINATION.relative_to(ROOT)))

if __name__=='__main__':main()

# generated: gpt-6 2026-11-06 role=assisted; LLM-authored portions; see PROVENANCE.md
