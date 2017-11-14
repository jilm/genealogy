# -*- coding: utf-8 -*-

import re
import sys
import codecs
import dictionary
import name
import place
import job

KEYWORDS = set(('widow', 'okres', 'years', 'born', 
    'died',
    'manžel', 'rozená', 'nemanželský'
))

RELATIONSHIPS = set(('father', 'mather', 'otec-otce', 'matka-otce',
    'otec-matky', 'matka-matky', 'kmotr', 'kmotra', 'křtil', 'vdova-po',
    'rozená'
))

def interpret(labeled_words):



with codecs.open('src/data/lidinsky.txt', 'r', encoding='utf-8') as f:
    data = f.read()
for line in data.splitlines():
    # split a line
    words = re.split('\s|:\s|,\s', line)
    # translate it
    words = list((dictionary.translate(word) for word in words))
    # label it
    labeled = list()
    for word in words:
        label = list()
        if name.is_given_name(word):
            label.append('GIVEN_NAME')
        if name.is_family_name(word):
            label.append('FAMILY_NAME')
        if place.is_parish_name(word):
            label.append('PARISH')
        if re.search('([1-3][0-9]|[1-9])\.([1-2][0-9]|[1-9])\.([1-2][0-9]{3})', word):
            label.append('DATE')
        if word in KEYWORDS:
            label.append('KEYWORD')
        if re.search('^[0-9]+$', word):
            label.append('NUMBER')
        if re.search('^\[.*\]$', word):
            label.append('REFERENCE')
        if job.is_job(word):
            label.append('JOB')
        if word in RELATIONSHIPS:
            label.append('RELATIONSHIP')
        if len(label) != 1:
            print(word, label)
        
