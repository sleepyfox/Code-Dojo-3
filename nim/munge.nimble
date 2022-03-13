# Package

version       = "0.1.0"
author        = "@sleepyfox"
description   = "An implementation of the munge code kata"
license       = "CC-BY-NC-SA-4.0"
srcDir        = "src"
bin           = @["munge"]

# Dependencies

requires "nim >= 1.6.4"

# Run tests

task test, "Runs the test suite":
  exec "nim c -r tests/munge_test"
