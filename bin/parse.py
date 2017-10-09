
import re
import sys
import datetime
import xml.etree.ElementTree as etree
from collections import deque

lang_dictionary = {'narozen': 'born', 'narozena': 'born', 'otec': 'father', 'matka': 'mather'}

def translate(word):
    if word in lang_dictionary:
        return lang_dictionary[word]
    else:
        return word

def parse_line(line):
    record = {}
    # Each record starts with optional referece which is enclosed by the
    # square brackets
    ref, tail = parse_ref(line)
    if ref:
        record['reference'] = ref
    keys = deque(re.findall(',\s*([\w\-]*):', tail))
    keys_translated = map(translate, keys)
    print(keys_translated)
    values = deque(re.split(',\s*[\w\-]+:\s*', tail))
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
    values = deque(re.split('\s*,\s*', text))
    person['name'] = values.popleft()
    for value in values:
        for parse_funct in parse_funct_list:
            parse_result = parse_funct(value)
            if parse_result:
                person[parse_result[0]] = parse_result[1]
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
    if text in job_list:
        return 'job', text

def map_birth_record_to_person(birth_record):
    pass


# Initialization
# Load the list of places
tree = etree.parse('resources/places.xml')
root = tree.getroot()
parish_set = set()
for place in root.findall('place/parish'):
    parish_set.add(place.text)

# list of jobs
job_list = set(('nájemník', 'půlláník', 'převozník', 'přívozník'))

parse_funct_list = (parse_place, parse_job)

# Load and parse data from standard input
record_list = list()
for line in sys.stdin.read().split('\n'):
    if len(line.strip()) > 0:
        print(len(line.strip()))
        record_list.append(parse_line(line))

print(record_list)

person_list = list()
       
for record in record_list:
    if 'born' in record:
        person = {}
        person['name'] = record['born']['name']
        person_list.append(person)

print(person_list)