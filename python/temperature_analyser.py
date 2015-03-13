import re

class Temperature_Reading:
	def __init__(self, line):
		if not line:
			raise(ValueError)
		else:
			DATA_LINE_REGEXP = "\s+[12]\d{3}\s" # start line with a year
			valid = re.compile(DATA_LINE_REGEXP)
			if valid.match(line):
				self.line = line
			else:
				raise(ValueError)

class Temperature_Analyser:
	def __init__(self):
		TEMPERATURE_FILE = "heathrow-weather-data.txt"
		DIGITS_REGEXP = "\-?[\d\.]+\s"
		self.digits = re.compile(DIGITS_REGEXP)
		DATA_LINE_REGEXP = "\s+[12]\d{3}\s" # start line with a year
		valid = re.compile(DATA_LINE_REGEXP)
		self.lines = [line.strip() for line in open(TEMPERATURE_FILE) if valid.match(line) ]

	def count_lines(self):
		return len(self.lines)

	def tMax(self, line):
		TMAX_FIELD = 2
		results = self.digits.findall(line)
		return float(results[TMAX_FIELD])

	def tMin(self, line):
		TMIN_FIELD = 3
		results = self.digits.findall(line)
		return float(results[TMIN_FIELD])

	def calculate_spread(self, first, second):
		return abs(first - second)

	def extract_date(self, line):
		YEAR_FIELD = 0
		MONTH_FIELD = 1
		results = self.digits.findall(line)
		return results[YEAR_FIELD].strip() + "-" + results[MONTH_FIELD].strip()

	def minimum_spread(self):
		return min([self.calculate_spread(self.tMax(i), self.tMin(i)) for i in self.lines])
