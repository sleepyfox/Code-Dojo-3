import re

# Global module constants
YEAR_FIELD = 0
MONTH_FIELD = 1
TMAX_FIELD = 2
TMIN_FIELD = 3
DIGITS_REGEXP = "\-?[\d\.]+\s"
DATA_LINE_REGEXP = "\s+[12]\d{3}\s" # start line with a year

class Temperature_Reading:
	def __init__(self, line):
		digits = re.compile(DIGITS_REGEXP)
		valid = re.compile(DATA_LINE_REGEXP)
		if not line or not valid.match(line):
			raise(ValueError)
		else:
			self.line = line
			fields = digits.findall(line)
			self.date = fields[YEAR_FIELD].strip() + "-" + fields[MONTH_FIELD].strip()
			self.tMin = float(fields[TMIN_FIELD])
			self.tMax = float(fields[TMAX_FIELD])

	def calculate_spread(self):
		return abs(self.tMax - self.tMin)

class Temperature_Analyser:
	def __init__(self, file):
		self.digits = re.compile(DIGITS_REGEXP)
		valid = re.compile(DATA_LINE_REGEXP)
		self._lines = [line for line in open(file) if valid.match(line) ]
		self._readings = [Temperature_Reading(line) for line in self._lines]

	def count_lines(self):
		return len(self._readings)

	def minimum_spread(self):
		return min([i.calculate_spread() for i in self._readings])
