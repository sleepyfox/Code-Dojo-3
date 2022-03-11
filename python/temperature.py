import re

# Global module constants
LOWEST = 0
YEAR_FIELD = 0
MONTH_FIELD = 1
TMAX_FIELD = 2
TMIN_FIELD = 3
DIGITS_REGEXP = "\-?[\d\.]+\s"
DATA_LINE_REGEXP = "\s+[12]\d{3}\s" # start line with a year

class Reading:
	def __init__(self, line):
		digits = re.compile(DIGITS_REGEXP)
		valid = re.compile(DATA_LINE_REGEXP)
		fields = digits.findall(line)
		if not line or not valid.match(line):
			raise(ValueError)
		else:
			self.date = fields[YEAR_FIELD].strip() + "-" + fields[MONTH_FIELD].strip()
			self.tMin = float(fields[TMIN_FIELD])
			self.tMax = float(fields[TMAX_FIELD])

	def calculate_spread(self):
		return abs(self.tMax - self.tMin)

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
