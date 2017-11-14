import difflib

def compare_names(name1, name2):
    return difflib.SequenceMatcher(None, name1.lower(), name2.lower()).ratio()