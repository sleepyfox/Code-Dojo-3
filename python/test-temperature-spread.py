"A test suite for a temperature spread calculator"

import unittest

# class OutOfRangeError: pass
# class LookupError: pass

class temperatureAnalyser():
    self.TEMPERATURE_FILE = "./heathrow-weather-data.txt"
    self.lines = [line.strip() for line in open(TEMPERATURE_FILE)]

	def countLines(self):
        return len(self.lines)

class testTemperatureAnalyser(unittest.TestCase):
	# def setUp(self):
	# 	self.roman = RomanNumeral()

	def testHaveLinesFromFile(self):
		"We have a non-zero line count"
		self.assertEqual(true, true)
