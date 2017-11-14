# -*- coding: utf-8 -*-

# list of jobs
JOB_NAMES = set((
    'nájemník', 
    'půlláník', 
    'převozník', 
    'podruh', 
    'domkář', 
    'nádeník', 
    'kaplan', 
    'domkářka',
    'výměnkář'
))

def is_job(word):
    return word in JOB_NAMES

