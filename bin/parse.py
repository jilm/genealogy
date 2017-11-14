# -*- coding: utf-8 -*-

import person
import re
import sys
import datetime
import xml.etree.ElementTree as etree
import dictionary
import job
import comparator
from collections import deque

status_list = set(('widow', 'single', 'married'))

def parse_line(line):
    record = {}
    # Each record starts with optional referece which is enclosed by the
    # square brackets
    ref, tail = parse_ref(line)
    if ref:
        record['reference'] = ref
    # split a line, where delimiter is a word that ends by the semicolon
    keys = deque(re.findall(',\s*([\S\-]*):', tail))
    keys_translated = map(dictionary.translate, keys)
    values = deque(re.split(',\s*[\S\-]+:\s*', tail))
    # first value contains a date and a place
    dateplace = deque(re.split('\s*,\s*', values.popleft()))
    for value in dateplace:
        date = parse_date(value)
        if date:
            record['date'] = date
            continue
        place = parse_place(value)
        if place:
            record['place'] = place
            continue
        print('unknown value', value)
    # process key, value pairs
    for key in keys_translated:
        value = values.popleft()
        record[key] = parse_person(value)
    return record

def parse_person(text):
    person = {}
    values = deque(map(dictionary.translate, re.split('\s*,\s*', text)))
    person['name'] = values.popleft()
    for value in values:
        for parse_funct in parse_funct_list:
            parse_result = parse_funct(value)
            if parse_result:
                person[parse_result[0]] = parse_result[1]
                break
    return person


def parse_ref(line):
    match = re.match('\[[0-9a-zA-Z:]+\]', line)
    if match:
        return match.group(), line[match.end():]
    else:
        return None, line

def parse_date(text):
    match = re.search('([1-3][0-9]|[1-9])\.([1-2][0-9]|[1-9])\.([1-2][0-9]{3})', text)
    if match:
        return datetime.date(int(match.group(3)), int(match.group(2)), int(match.group(1)))
    else:
        return None

def parse_place(text):
    if text in parish_set:
        return 'place', text
    match = re.search('^(\D+)\s+(\d+)', text)
    if match:
        parish = match.group(1)
        house_nr = match.group(2)
        if parish in parish_set:
            return 'place', parish

def parse_job(text):
    if text in job.job_list:
        return 'job', text

def parse_status(text):
    if text in status_list:
        return 'status', text

def parse_age(text):
    match = re.search('([0-9]+)\s+(\S+)', text)
    if match:
        if dictionary.translate(match.group(2)) == 'years':
            return 'age', int(match.group(1))

def complain(text):
    print(text)

def map_birth_record_to_person(birth_record):
    pass

def compare(birth_record, death_record):
    """ Takes birth and death record and return a real number between zero
    and one, where zero means, that given records belongs to completly
    different people whereas one means that these records describe the same
    person. """
    # Compare names
    pass


# Initialization
# Load the list of places
tree = etree.parse('resources/places.xml')
root = tree.getroot()
parish_set = set()
for place in root.findall('place/parish'):
    parish_set.add(place.text)


parse_funct_list = (parse_place, parse_job, parse_status, parse_age, complain)

# Load and parse data from standard input
birth_record_list = list()
death_record_list = list()
for line in sys.stdin.read().split('\n'):
    if len(line.strip()) > 0:
        record = parse_line(line)
        if 'born' in record:
            birth_record_list.append(record)
        elif 'death' in record:
            death_record_list.append(record)

person_list = list()
       
for record in birth_record_list:
    p = person.Person(record['born']['name'])
    p.birth_date = record['date']
    person_list.append(p)

for record in death_record_list:
    p = person.Person(record['died']['name'])
    p.death_date = record['date']
    p.age = record['died']['age']
    person_list.append(p)

for p in person_list: print(p)

for i in birth_record_list:
    for j in death_record_list:
        print(i.name, j.name, comparator.compare_names(i.name, j.name))
