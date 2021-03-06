"A test suite for a temperature spread calculator"

import unittest
import temperature

class test_Reading(unittest.TestCase):
	def test_can_create_reading_from_line(self):
		"creating a temperature reading from an empty string throws an exception"
		with self.assertRaises(ValueError):
			reading = temperature.Reading("")

	def test_throw_exception_on_header_line(self):
		"Invalid data e.g. header line throws an exception"
		with self.assertRaises(ValueError):
			reading = temperature.Reading("Heathrow (London Airport)")

	def test_extract_date(self):
		"a temperature reading should have the correct date"
		line = "   1948   5   18.1     6.9    ---     57.0    ---"
		self.assertEqual(temperature.Reading(line).date, "1948-5")

	def test_extract_high_temp_from_line(self):
		"Test that high temp from string is 18.1"
		line = "   1948   5   18.1     6.9    ---     57.0    ---"
		self.assertEqual(temperature.Reading(line).tMax, 18.1)

	def test_extract_low_temp_from_line(self):
		"Test that the low temp from string is 6.9"
		line = "   1948   5   18.1     6.9    ---     57.0    ---"
		self.assertEqual(temperature.Reading(line).tMin, 6.9)

	def test_extract_negative_low_temp_from_line(self):
		"Test we can extract a negative tMin of -1.3"
		line = "   1991   2    5.4    -1.3      16    34.7    48.5"
		self.assertEqual(temperature.Reading(line).tMin, -1.3)

	def test_spread_zero(self):
		"The spread between zero and zero is zero"
		line = "   1991   2    0.0    0.0      16    34.7    48.5"
		self.assertEqual(temperature.Reading(line).calculate_spread(), 0)

	def test_spread_positive(self):
		"The spread between 4 and 1 is 3"
		line = "   1991   2    4.0    1.0      16    34.7    48.5"
		self.assertEqual(temperature.Reading(line).calculate_spread(), 3)

	def test_spread_abs_value(self):
		"The spread between 3 and 5 is 2"
		line = "   1991   2    3.0    5.0      16    34.7    48.5"
		self.assertEqual(temperature.Reading(line).calculate_spread(), 2)

	def test_spread_with_negative_tMin(self):
		"The spread between 2.5 and -1.5 should be 4"
		line = "   1991   2    2.5   -1.5      16    34.7    48.5"
		self.assertEqual(temperature.Reading(line).calculate_spread(), 4)

class test_Analyser(unittest.TestCase):
	@classmethod
	def setUpClass(self):
		TEMPERATURE_FILE = "heathrow-weather-data.txt"
		self.analyser = temperature.Analyser(TEMPERATURE_FILE)

	def test_have_lines_from_file(self):
		"We have a non-zero line count"
		self.assertTrue(self.analyser.count_lines() > 0)

	def test_calc_minimum_spread_from_list(self):
		"Test that getting a minimum from a sequence of spreads"
		spreads = [2, 3, 1, 4, 8]
		self.assertEqual(min(spreads), 1)

	def test_minimum_spread_from_all_data(self):
		"Correct minimum spread should be 3.8 degrees"
		self.assertEqual(self.analyser.minimum_spread().calculate_spread(), 3.8)

	def test_minimum_spread_date(self):
		"minimum spread should occur in Dec 2002"
		self.assertEqual(self.analyser.minimum_spread().date, '2002-12')

if __name__ == "__main__":
	unittest.main()
