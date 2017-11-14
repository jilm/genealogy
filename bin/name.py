# -*- coding: utf-8 -*-

import codecs

# Read a list of all of the given names from a text file
with codecs.open('resources/names.txt', 'r', encoding='utf-8') as f:
    GIVEN_NAMES = set(f.read().splitlines())
    FAMILY_NAMES_MALE = set()
with codecs.open('resources/cet_prijm_muzi-utf8.csv', 'r', encoding='utf-8') as f:
    for line in f.read().splitlines():
        FAMILY_NAMES_MALE.add(line.split(';')[0])
    FAMILY_NAMES_FEMALE = set()
with codecs.open('resources/cet_prijm_zeny-utf8.csv', 'r', encoding='utf-8') as f:
    for line in f.read().splitlines():
        FAMILY_NAMES_FEMALE.add(line.split(';')[0])
print(FAMILY_NAMES_FEMALE)

def is_given_name(name):
    return name in GIVEN_NAMES

def is_family_name(name: str):
    return (name.upper() in FAMILY_NAMES_FEMALE) or (name.upper() in FAMILY_NAMES_MALE)

def is_name(name):
    return is_given_name(name) or is_family_name(name)

def label(words: list):
    if is_name(words[0]):
        return create_name(words)
    else:
        return None

def create_name(words: list):
    name = Name()
    while len(words) > 0:
        name.add(words.pop(0))
        if is_name(words[0]):
            continue
        else:
            return name

class Name:
    
    def __init__(self):
        self.given = None
        self.second = None
        self.family = None

    def __str__(self):
        print(self.given, ' ', self.family)

    def add(self, name):
        if is_family_name(name):
            if self.family:
                print('!!! Two family names ! ', self.family, ' ', name)
            else:
                self.family = name
        elif is_given_name(name):
            if self.given and self.second:
                print('!!! The third given name !')
            elif self.given:
                self.second = name
            else:
                self.given = name
        else:
            print('!!! Not a name', name)

