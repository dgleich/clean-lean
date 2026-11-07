# generated: gpt-6 2026-11-07 role=assisted; see PROVENANCE.md
"""Reproduce historical patch studies independently of the working compiler."""
from pathlib import Path
import io
import shutil
import subprocess
import tarfile

# Last recorded compiler before the seven binding repairs are integrated.
BASE_COMMIT = 'fa2c297cf833bfc1f126606eaeac2cb53849c453'


def create_study_checkout(destination, root):
    """Export the pinned baseline, overlay tracked study inputs, reuse dependencies.

    Historical compiler, library, test and generator files come from BASE_COMMIT.
    Study sources/drivers/patches come from the current tracked worktree so a new
    experiment can be exercised before committing it. Untracked inputs are never
    copied. The caller owns the fresh destination and its lifetime.
    """
    destination, root = Path(destination).resolve(), Path(root).resolve()
    destination.mkdir(parents=True, exist_ok=True)
    if any(destination.iterdir()):
        raise ValueError('Study checkout destination must be empty')
    check = subprocess.run(['git', 'cat-file', '-e', BASE_COMMIT + '^{commit}'],
                           cwd=root, capture_output=True)
    if check.returncode:
        raise RuntimeError('Historical study baseline '+BASE_COMMIT+
                           ' is unavailable; fetch repository history before running patch studies')
    archive = subprocess.check_output(['git', 'archive', '--format=tar', BASE_COMMIT], cwd=root)
    with tarfile.open(fileobj=io.BytesIO(archive), mode='r:') as tree:
        tree.extractall(destination)
    # All paths originate in this repository's tracked study inventory.
    names = subprocess.check_output(['git', 'ls-files', '-z', '--', 'studies',
                                     'tools/study_checkout.py'], cwd=root, text=True).split('\0')
    # Deleted current study inputs must not remain as stale files from the archive.
    shutil.rmtree(destination / 'studies')
    for name in names:
        if name and (root / name).is_file():
            target = destination / name
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(root / name, target)
    (destination / '.lake').symlink_to(root / '.lake', target_is_directory=True)

# generated: 2026-10-23 role=assisted; LLM-authored portions; see PROVENANCE.md
