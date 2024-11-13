import macros
#import macroDebug
import strformat

# Define custom countup and countdown iterators for floating-point numbers
iterator floatCountup(start, stop, step: float): float =
  var i = start
  while i <= stop:
    yield i
    i += step

iterator floatCountdown(start, stop, step: float): float =
  var i = start
  while i >= stop:
    yield i
    i -= step

macro float_range_inclusive*(start, stop; step: untyped = nil): untyped =
  var stepValue = 0.0
  if step == nil:
    static:
        echo("step get default value 1.0")
    stepValue = 1.0
  else:
    if step.kind == nnkFloatLit:
        echo(fmt"step.kind is {step.kind}")
        stepValue = step.floatVal
    else:
        stepValue = 1.0
        static:
            echo("step.kind is not nnkFloatLit")
        echo(fmt"step.kind is {step.kind}")
        error(fmt"step.kind is {step.kind}")

  #let stepValue = 1 #stepNode.intVal  # Get the integer value of `step`
  
  if stepValue > 0:
    result = quote do: floatCountup(`start`, `stop`, `stepValue`)
  elif stepValue < 0:
    result = quote do: floatCountdown(`start`, `stop`, abs(`step`))
  else:
    error("Step must be non-zero")

macro float_range_exclusive*(start: float, stop: float, step: float = 1.0): untyped =
  let stepValue = step.floatVal  # Get the integer value of `step`
  
  if stepValue > 0:
    result = quote do: floatCountup(`start`, `stop`-`step`, `step`)
  elif stepValue < 0:
    result = quote do: floatCountdown(`start`, `stop`-`step`, abs(`step`))
  else:
    error("Step must be non-zero")

template compileMessage(msg: string) =
  static:
    echo "Compile-time message: " & msg

template is_int_kind(token: NimNode): bool =
  (token.kind == nnkIntLit) or
  (token.kind == nnkInt8Lit) or
  (token.kind == nnkInt16Lit) or
  (token.kind == nnkInt32Lit) or
  (token.kind == nnkInt64Lit) or
  (token.kind == nnkUIntLit) or
  (token.kind == nnkUInt8Lit) or
  (token.kind == nnkUInt16Lit) or
  (token.kind == nnkUInt32Lit) or
  (token.kind == nnkUInt64Lit) or
  (token.kind == nnkInfix)

macro range_inclusive*(start, stop; step: untyped = nil): untyped =
  var stepValue = 0
  if step == nil:
    stepValue = 1
  else:
    if is_int_kind(step):
        stepValue = step.intVal
    else:
        stepValue = 1

  if stepValue > 0:
    result = quote do: countup(`start`, `stop`, `stepValue`)
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

# Example usage
proc main() =
    stdout.write("Hello, world!\n")

main()

test "basic std":
    stdout.write("Standard int range [1, 10] by default 1, range_inclusive(1, 10)\n")
    for i in range_inclusive(1, 10):   # Expands to countup(1, 10, 1)
        stdout.write(fmt"{i} ")
    stdout.write("\n")

    stdout.write("Standard int range [1, 10] by 2, range_inclusive(1, 10, 2)\n")
    for i in range_inclusive(1, 10, 2):   # Expands to countup(1, 10, 2)
        stdout.write(fmt"{i} ")
    stdout.write("\n")

    stdout.write("Standard backward int range [10, 1] by -2, range_inclusive(10, 1, -2)\n")
    for i in range_inclusive(10, 1, -2):  # Expands to countdown(10, 1, -2)
        stdout.write(fmt"{i} ")
    stdout.write("\n")

test "float std":
    stdout.write("Float range [1.0, 3.0] by default 1.0, float_range_inclusive(1.0, 3.0)\n")
    for i in float_range_inclusive(1.0, 3.0):  # Expand to floatCountup(1.0, 3.0, 1.0)
        stdout.write(fmt"{i} ")
    stdout.write("\n")

    stdout.write("Float range [1.0, 3.0] by 0.5, float_range_inclusive(1.0, 3.0, 0.5)\n")
    for i in float_range_inclusive(1.0, 3.0, 0.5):
        stdout.write(fmt"{i} ")
    stdout.write("\n")

    stdout.write("Backward float range [3.0, 1.0] by -0.5, float_range_inclusive(3.0, 1.0, -0.5)\n")
    for i in float_range_inclusive(3.0, 1.0, -0.5):
        stdout.write(fmt"{i} ")
    stdout.write("\n")
