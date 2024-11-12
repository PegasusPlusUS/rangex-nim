# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.

import rangex/submodule

proc main() =
  for i in range_inclusive(0, 10, 2):
    echo i  # This will print 0, 2, 4, 6, 8, 10

  for i in range_inclusive(10, 2, -2):
    echo i  # This will print 10, 8, 6, 4, 2

main()

when isMainModule:
  echo("Hello, world!")
