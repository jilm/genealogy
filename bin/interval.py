""" What I need is a date representation, but sometimes the date is not known
at all, sometimes we know some interval. If I know only the birth year of some
person, the birth probability of each particular day of that year is 1/365. """

import datetime


class Interval:
    """ Represents uniformly distributed probability inside some bounded
    interval. """
    def __init__(self):
        self.date_from = datetime.date(1700, 1, 1)
        self.date_to = datetime.date(2017, 1, 1)

    def intersection(self, interval):
        """ Returns an intersection between this interval and parameter. """
        pass

    
