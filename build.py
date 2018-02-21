#!/usr/bin/env python
"""Build tex documents and remove the intermediate files."""

from pathlib import Path
from subprocess import call
from shutil import which
from os import remove


root = Path(__file__).parent
latex = root/'Latex'
out = root/'out'
lualatex = which('lualatex')

for tex in (file for file in latex.iterdir() if file.suffix == '.tex'):
    call([lualatex, '--output-directory', out, tex])

for itermediate in (file for file in out.iterdir() if file.suffix != '.pdf'):
    remove(itermediate)
