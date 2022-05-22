import math
import unittest
import temp_spread

const
  t = "   1948   1    8.9     3.3    ---     85.0    ---"
  t2 = "   1950   2    9.9     2.3    ---     85.0    ---"
  tokens = temp_reader(t)
  temp = strings_to_temp(tokens)

suite "a temperature record reader":
  test "year is 1948":
    check(tokens[0] == "1948")
  test "token array has seven elements":
    check(tokens.len == 7)
  test "max_temp is 8.9":
    check(tokens[2] == "8.9")

suite "a temperature record object":
  test "can be created from a seq of strings":
    check(temp.year == 1948)
  test "month is 1":
    check(temp.month == 1)
  test "maximum recorded temperature is 8.9C":
    check(temp.max_temp == 8.9)
  test "minimum recorded temperature is 3.3C":
    check(temp.min_temp == 3.3)

suite "a temperature spread calculator":
  test "should record a spread of 5.6C":
    check(almostEqual(spread(temp).temp_spread, 5.6))

suite "a temperature spread object":
  let
    smaller = spread(temp)
    bigger = spread(strings_to_temp(temp_reader(t2)))
  test "should know which spread is smaller":
    check(smaller < bigger)
  test "and which is bigger":
    check((bigger < smaller) == false)

suite "a sequence of temp spread objects":
  let
    smaller = spread(temp)
    bigger = spread(strings_to_temp(temp_reader(t2)))
    spreads = @[smaller, bigger]
  test "we should be able to find the smallest":
    check(spreads.min().year == 1948)
    check(spreads.min().month == 1)
  test "we should be able to find the biggest":
    check(spreads.max().year == 1950)
    check(spreads.max().month == 2)


# Integration tests
import strutils

suite "a file processor":
  test "should remove the header":
    let records = process_file("../heathrow-weather-data.txt")
    check(records[0].strip()[0..3] == "1948")

  test "should not have a blank line at the end":
    let records = process_file("../heathrow-weather-data.txt")
    check(records.len == 806)
