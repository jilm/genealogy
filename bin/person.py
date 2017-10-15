import interval
import datetime

class Person:
    """ Person data. """
    def __init__(self, name):
        self.name = name
        self.birth_date = None
        self.birth_place = None
        self.birth_reference = None
        self.death_date = None
        self.death_place = None
        self.death_reference = None
        self.age = None
        self.death_cause = None
        self.wedding = list()
        self.mather = None
        self.father = None
        self.children = list()

    def __str__(self):
        s = self.name
        if self.birth_date:
            s += ' * ' + str(self.get_birth_date())
        return s

    def is_alive(self, date):
        """ Return true, if it is likely, that the person is aleve."""
        pass
    
    def get_birth_date(self):
        if self.birth_date:
            return self.birth_date
        elif self.death_date:
            if self.age:
                return datetime.date(self.death_date.year - self.age, self.death_date.month, self.death_date.day)
