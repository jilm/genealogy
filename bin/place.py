# -*- coding: utf-8 -*-

import codecs

NONEXISTENT = (('Lipovsko'))

def is_parish_name(name):
    return (name in PARISH_NAMES) or (name in NONEXISTENT)

# Read a list of all of the names of places
PARISH_NAMES = set()
with codecs.open('resources/souradnice.csv', 'r', encoding='utf-8') as f:
    for line in f.read().splitlines():
        values = line.split(',')
        PARISH_NAMES.add(values[0])
