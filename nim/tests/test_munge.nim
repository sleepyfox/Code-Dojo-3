import math
import strutils
import unittest

doAssert almostEqual(PI, 3.14159265358979)

const t = "   1948   1    8.9     3.3    ---     85.0    ---"

type
  Temp = object
    year: int
    month: int
    max_temp: float
    min_temp: float

type
  TempSpread = object
    year: int
    month: int
    temp_spread: float

proc temp_reader(line: string): seq[string] =
  splitWhitespace(line)

proc strings_to_temp(ts: seq[string]): Temp =
  Temp(year: ts[0].parseInt(),
       month: ts[1].parseInt(),
       max_temp: ts[2].parseFloat(),
       min_temp: ts[3].parseFloat())

proc spread(t: Temp): TempSpread =
  TempSpread(year: t.year,
             month: t.month,
             temp_spread: t.max_temp - t.min_temp)

const tokens = temp_reader(t)
const temp = strings_to_temp(tokens)

suite "a temperature record reader":
  test "year is 1948":
    check(tokens[0] == "1948")
  test "token array has seven elements":
    check(tokens.len == 7)
  test "max_temp is 8.9":
    check(tokens[2] == "8.9")

suite "a Temperature record object":
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