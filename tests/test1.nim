# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest

import rangex/submodule


test "range_inclusive":
  var s = 0
  for i in range_inclusive(1, 100):
    s += i
  check s == 5050
  s = 0
  for i in range_inclusive(100, 1, -1):
    s += i
  check s == 5050

test "range_exclusive":
  var s = 0
  for i in range_exclusive(1, 101):
    s += i
  check s == 5050
  s = 0
  for i in range_exclusive(100, 0, -1):
    s += i
  check s == 5050

test "empty range":
  var s = 0
  for i in range_inclusive(1, 1):
    s += i
  check s == 1
  s = 0
  for i in range_exclusive(1, 1):
    s += i
  check s == 0

test "empty range backward":
  var s = 0
  for i in range_inclusive(1, 1, -1):
    s += i
  check s == 1
  s = 0
  for i in range_exclusive(1, 1, -1):
    s += i
  check s == 0

# test "float std":
#   # Use the macro in a for loop directly
#   for i in range_inclusive(1.0, 10.0, 2.0):   # Expands to countup(1, 10, 2)
#       stdout.write(fmt"{i} ")
#   stdout.write("\n")

#   for i in range_inclusive(10.0, 1.0, -2.0):  # Expands to countdown(10, 1, -2)
#       stdout.write(fmt"{i} ")
#   stdout.write("\n")
