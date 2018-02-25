#!/usr/bin/env python
"""Combine cover and resume pdf."""

from pathlib import Path
from subprocess import call
from shutil import which


root = Path(__file__).parent
out = root/'out'
pdftk = which('pdftk')
covers = (
    (file.name.split('_')[0], file.absolute())
    for file in out.iterdir()
    if file.name.endswith('_cover.pdf')
)

for name, cover in covers:
    call([
        pdftk,
        cover, out/'software_resume.pdf',
        'cat', 'output', out/f'{name}_resume.pdf'
    ])
