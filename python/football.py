import re

# Global module constants
LOWEST = 0
GOALS_FOR_FIELD = 5
GOALS_AGAINST_FIELD = 6
DIGITS_REGEXP = "[\d\.]+\s"
DATA_LINE_REGEXP = "\s+\d{1,2}\.\s([A-Za-z_]+)" # start line with a number and a team

class Reading:
  def __init__(self, line):
    digits = re.compile(DIGITS_REGEXP)
    valid = re.compile(DATA_LINE_REGEXP)
    fields = digits.findall(line)
    if not line or not valid.match(line):
      raise(ValueError)
    else:
      self.team = re.match(DATA_LINE_REGEXP, line).group(1)
      self.goals_for = int(fields[GOALS_FOR_FIELD])
      self.goals_against = int(fields[GOALS_AGAINST_FIELD])

  def calculate_spread(self):
    return abs(self.goals_for - self.goals_against)

class Analyser:
  def __init__(self, file):
    valid = re.compile(DATA_LINE_REGEXP)
    self._lines = [line for line in open(file) if valid.match(line)]
    self._readings = [Reading(line) for line in self._lines]

  def count_lines(self):
    return len(self._readings)

  def minimum_spread(self):
    sorted_readings = sorted(self._readings, key = lambda x: x.calculate_spread())
    return sorted_readings[LOWEST]
