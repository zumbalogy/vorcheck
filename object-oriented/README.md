
## Object Oriented Programming

**Language: Any language that supports object-oriented design**

In the `object-oriented` directory, implement a `Grade` class that implements a
reasonable API for grades that look like the letter grading system (i.e., A+, A,
A-, B+, B, ...)

### Requirements

  - This should instantiate from a String. It should also deserialize to a
    String. This will grades to be stored in a database as a String, but act as
    a value object within an application
  - Equality should work properly. (`Grade.new('a') == Grade.new('A')`)
  - Sorting should work properly (e.g., `a- < a < a+`), given an Array of
    of `Grades`, the `array.sort` should work as expected.
