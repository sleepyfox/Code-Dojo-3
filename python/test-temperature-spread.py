"A test suite for a temperature spread calculator"

import unittest
import re

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


class test_Temperature_Analyser(unittest.TestCase):
	@classmethod
	def setUpClass(self):
		self.temps = Temperature_Analyser()

	def test_have_lines_from_file(self):
		"We have a non-zero line count"
		self.assertTrue(self.temps.count_lines() > 0)

	def test_spread_zero(self):
		"The spread between zero and zero is zero"
		self.assertEqual(self.temps.calculate_spread(0, 0), 0)

	def test_spread_positive(self):
		"The spread between 4 and 1 is 3"
		self.assertEqual(self.temps.calculate_spread(4,1), 3)

	def test_spread_abs_value(self):
		"The spread between 3 and 5 is 2"
		self.assertEqual(self.temps.calculate_spread(3,5), 2)

	def test_spread_with_negative_tMin(self):
		"The spread between 2 and -1 should be 3"
		self.assertEqual(self.temps.calculate_spread(2, -1), 3)

	def test_extract_high_temp_from_line(self):
		"Test that high temp from string is 18.1"
		line = "   1948   5   18.1     6.9    ---     57.0    ---"
		self.assertEqual(self.temps.tMax(line), 18.1)

	def test_extract_low_temp_from_line(self):
		"Test that the low temp from string is 6.9"
		line = "   1948   5   18.1     6.9    ---     57.0    ---"
		self.assertEqual(self.temps.tMin(line), 6.9)

	def test_extract_negative_low_temp_from_line(self):
		"Test we can extract a negative tMin of -1.3"
		line = "   1991   2    5.4    -1.3      16    34.7    48.5"
		self.assertEqual(self.temps.tMin(line), -1.3)

	def test_calc_minimum_spread_from_list(self):
		"Test that getting a minimum from a sequence of spreads"
		spreads = [2, 3, 1, 4, 8]
		self.assertEqual(min(spreads), 1)

	def test_date_extraction(self):
		"Test that we can extract the year and month"
		line = "   1948   5   18.1     6.9    ---     57.0    ---"
		self.assertEqual(self.temps.extract_date(line), "1948-5")

	def test_minimum_spread_from_all_data(self):
		self.assertEqual(self.temps.minimum_spread(), 3.8)

if __name__ == "__main__":
	unittest.main()
