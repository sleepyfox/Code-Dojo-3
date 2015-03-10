"A test suite for a temperature spread calculator"

import unittest
import re
#    1948   5   18.1     6.9    ---     57.0    ---
# class OutOfRangeError: pass
# class LookupError: pass

class TemperatureAnalyser:
	TEMPERATURE_FILE = "heathrow-weather-data.txt"
	lines = [line.strip() for line in open(TEMPERATURE_FILE)]

	def countLines(self):
		return len(TemperatureAnalyser.lines)

	def tMax(self, line):
		THIRD_MATCH = 2
		DIGITS_REGEXP = "[\d\.]+"
		digits = re.compile(DIGITS_REGEXP)
		results = digits.findall(line)
		return float(results[THIRD_MATCH])

	def tMin(self, line):
		FOURTH_MATCH = 3
		DIGITS_REGEXP = "[\d\.]+"
		digits = re.compile(DIGITS_REGEXP)
		results = digits.findall(line)
		return float(results[FOURTH_MATCH])

	def calculate_spread(self, first, second):
		return first - second

class testTemperatureAnalyser(unittest.TestCase):
	def setUp(self):
		self.temps = TemperatureAnalyser()

	def testHaveLinesFromFile(self):
		"We have a non-zero line count"
		self.assertEqual(self.temps.countLines(), 813)

	def testSpreadZero(self):
		"The spread between zero and zero is zero"
		self.assertEqual(self.temps.calculate_spread(0, 0), 0)

	def testSpreadPositive(self):
		"The spread between 4 and 1 is 3"
		self.assertEqual(self.temps.calculate_spread(4,1), 3)

	def testExtractHighTemp(self):
		"Test that high temp from string is 18.1"
		line = "   1948   5   18.1     6.9    ---     57.0    ---"
		self.assertEqual(self.temps.tMax(line), 18.1)

	def testExtractLowTemp(self):
		"Test that the low temp from string is 6.9"
		line = "   1948   5   18.1     6.9    ---     57.0    ---"
		self.assertEqual(self.temps.tMin(line), 6.9)

if __name__ == "__main__":
	unittest.main()
