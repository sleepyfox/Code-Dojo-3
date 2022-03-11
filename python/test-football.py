"A test suite for a football score spread calculator"

import unittest
import football

class test_Reading(unittest.TestCase):
  def test_can_create_reading_from_line(self):
    "creating a football score reading from an empty string throws an exception"
    with self.assertRaises(ValueError):
      reading = football.Reading("")

  def test_throw_exception_on_header_line(self):
    "Invalid data e.g. header line throws an exception"
    with self.assertRaises(ValueError):
      reading = football.Reading("Heathrow (London Airport)")

  def test_extract_date(self):
    "a football reading should have a team"
    line = "  1. Arsenal     38  26   9   3  79  -  36  87"
    self.assertEqual(football.Reading(line).team, "Arsenal")

  def test_goals_for_from_line(self):
    "Test that goals for from string is 79"
    line = "  1. Arsenal     38  26   9   3  79  -  36  87"
    self.assertEqual(football.Reading(line).goals_for, 79)

  def test_extract_goals_against_from_line(self):
    "Test that the goals against from string is 36"
    line = "  1. Arsenal     38  26   9   3  79  -  36  87"
    self.assertEqual(football.Reading(line).goals_against, 36)

  def test_spread_zero(self):
    "The spread between zero and zero is zero"
    line = "  1. Arsenal     38  26   9   3  9  -  9  87"
    self.assertEqual(football.Reading(line).calculate_spread(), 0)

  def test_spread_positive(self):
    "The spread between 4 and 1 is 3"
    line = "  1. Arsenal     38  26   9   3  4  -  1  87"
    self.assertEqual(football.Reading(line).calculate_spread(), 3)

  def test_spread_abs_value(self):
    "The spread between 3 and 5 is 2"
    line = "  1. Arsenal     38  26   9   3  3  -  5  87"
    self.assertEqual(football.Reading(line).calculate_spread(), 2)


class test_Analyser(unittest.TestCase):
  @classmethod
  def setUpClass(self):
    self.analyser = football.Analyser("football.dat")

  def test_have_lines_from_file(self):
    "We have a non-zero line count"
    self.assertTrue(self.analyser.count_lines() > 0)

  def test_calc_minimum_spread_from_list(self):
    "Test that getting a minimum from a sequence of spreads"
    spreads = [2, 3, 1, 4, 8]
    self.assertEqual(min(spreads), 1)

  def test_minimum_spread_from_all_data(self):
    "Correct minimum spread should be 1 goal"
    self.assertEqual(self.analyser.minimum_spread().calculate_spread(), 1)

  def test_minimum_spread_date(self):
    "minimum spread should occur in Dec 2002"
    self.assertEqual(self.analyser.minimum_spread().team, 'Aston_Villa')

if __name__ == "__main__":
  unittest.main()
