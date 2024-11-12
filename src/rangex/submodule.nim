import macros

macro range_inclusive*(start: int, stop: int, step: int = 1): untyped =
  let stepValue = step.intVal  # Get the integer value of `step`
  
  if stepValue > 0:
    result = quote do: countup(`start`, `stop`, `step`)
  elif stepValue < 0:
    result = quote do: countdown(`start`, `stop`, abs(`step`.int))
  else:
    error("Step must be non-zero")

macro range_exclusive*(start: int, stop: int, step: int = 1): untyped =
  let stepValue = step.intVal  # Get the integer value of `step`
  
  if stepValue > 0:
    result = quote do: countup(`start`, `stop`-`step`, `step`)
  elif stepValue < 0:
    result = quote do: countdown(`start`, `stop`-`step`, abs(`step`.int))
  else:
    error("Step must be non-zero")

# Usage example
import strformat
import unittest

test "basic std":
    # Use the macro in a for loop directly
    for i in range_inclusive(1, 10, 2):   # Expands to countup(1, 10, 2)
        stdout.write(fmt"{i} ")
    stdout.write("\n")

    for i in range_inclusive(10, 1, -2):  # Expands to countdown(10, 1, -2)
        stdout.write(fmt"{i} ")
    stdout.write("\n")
