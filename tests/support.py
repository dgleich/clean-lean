"""Test fixtures explicitly import the definitions they exercise."""
from pathlib import Path
from cleanlang.core import Environment
from cleanlang.modules import load_module
ROOT=Path(__file__).resolve().parents[1]

def standard_environment():
    env=Environment()
    load_module(ROOT/'library/standard.clean',env)
    return env

def statement_text(path):
    return '\n'.join(line if not line.startswith('Import ') else '' for line in path.read_text().splitlines())+'\n'

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
