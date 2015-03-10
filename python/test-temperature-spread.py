"A test suite for a temperature spread calculator"

import unittest

# class OutOfRangeError: pass
# class LookupError: pass

class TemperatureAnalyser:
	TEMPERATURE_FILE = "heathrow-weather-data.txt"
	lines = [line.strip() for line in open(TEMPERATURE_FILE)]

	def countLines(self):
		return len(TemperatureAnalyser.lines)

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

if __name__ == "__main__":
	unittest.main()
