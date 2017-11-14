# -*- coding: utf-8 -*-

import codecs

DICTIONARY = {}
# Read a dictionary
with codecs.open('resources/dictionary.txt', 'r', encoding='utf-8') as f:
    for line in f.read().splitlines():
        values = line.split(',')
        DICTIONARY[values[0]] = values[1]


def translate(word):
    """ Takes argument, and return value from the dictionary. """
    if word in DICTIONARY:
        return DICTIONARY[word]
    else:
        return word

