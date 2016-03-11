#!/usr/bin/env python
import os
import re
import string
from distutils.core import setup, Extension

def find_cxx(d):
    for root, dirs, files in os.walk(d):
        for f in files:
            if re.match('.*\.cxx$', f):
                yield os.path.join(root, f)

def find_submodules(d):
    for root, dirs, files in os.walk(d):
        for f in files:
            if re.match('.*\.py$', f):
                path  = os.path.join(root, f)
                noext = string.rstrip(path, '.py')
                yield string.replace(noext, os.sep, '.')


extensions = []
for cxx in find_cxx('libbitcoin'):
    base      = os.path.basename(cxx)
    ext_name  = string.replace("_%s" % base, '_wrap.cxx', '')
    extension = Extension(ext_name,
        extra_compile_args = ['-std=c++11'],
        libraries          = ['bitcoin', 'boost_system'],
        sources            = [cxx]
    )
    extensions.append(extension)

setup(
    name        = 'libbitcoin',
    ext_modules = extensions,
    py_modules  = list(find_submodules('libbitcoin')),
)
