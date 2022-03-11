import unittest
import strutils

const t = "   1948   1    8.9     3.3    ---     85.0    ---"

proc temp_reader(line: string): seq[string] =
  splitWhitespace(line)

suite "a temperature record reader":
  test "can read a string ":
    check(temp_reader(t)[0] == "1948")
  test "token array has seven elements":
    check(temp_reader(t).len == 7)
