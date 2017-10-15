import datetime


class Interval:
    """ Represents uniformly distributed probability inside some bounded
    interval. """
    def __init__(self):
        self.date_from = datetime.date(1700, 1, 1)
        self.date_to = datetime.date(2017, 1, 1)

