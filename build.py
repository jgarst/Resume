#!/usr/bin/env python

from pathlib import Path
from subprocess import call
from shutil import which
from glob import glob

here = Path(__file__).parent

call([
    which('lualatex'),
    '--output-directory', here/'out',
    *glob(str(here/'Latex'/'*.tex'))
])
