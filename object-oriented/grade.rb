# Implement a Grade class that implements a reasonable API for grades
# that look like the letter grading system (i.e. A+, A, A-, B+, B, ...)

# Requirements:

#   This should instantiate from a String.

#   It should also deserialize to a String.
#   This will allow grades to be stored in a database as a String,
#   but act as a value object within an application

#   Equality should work properly. (Grade.new('a') == Grade.new('A'))

#   Sorting should work properly (e.g., a- < a < a+),
#   given an Array of of Grades, the array.sort should work as expected.

#########################################################################

# I was going to validate input numbers from 0..100 but I guess there is
# the possibility of extra credit.

# Comparison currently works even against strings, so Grade.new('a') == 'A'
# to change that the == method could just be "@mark == other.mark"

# Overriding inspect is maybe heavy handed, could just do to_s instead.

# As far as serialization goes (I think the problem description might
# have it backwards calling it deserialization) it would just be
# a matter of having Grade inherit from ActiveRecord::Base
# and saying "serialize :mark".

# Native Ruby's foo = Marshal.dump(Grade.new('A+')) and Marshal.load(foo) works
# out of the box, but there is only 15 possibilities,
# so storing it as 4 bits would probably be the most space efficient.

#########################################################################


class Grade
  include Comparable

  @@letter_regex = /^[abcdef][+-]?$/i
  @@number_regex = /^[0-9]+$|^[0-9]+\.[0-9]+$/

  attr_accessor :mark

  def Grade.valid_grade?(input)
    return true if input.is_a?(Numeric)
    match = input[/#{@@letter_regex}|#{@@number_regex}/]
    match ? true : false
  end

  def Grade.to_letter(input)
    raise 'This is an error.' unless Grade.valid_grade?(input)
    return input if input.is_a?(String)
    i = input.to_i
    return 'a+' if i > 98
    return 'f-' if i < 3
    grades = { 6 => 'd', 7 => 'c', 8 => 'b', 9 => 'a' }
    out = grades[i / 10]
    out = 'f' if i < 60
    out = 'a' if i > 89
    out += '-' if (i % 10) < 2
    out += '+' if (i % 10) > 7
    out
  end

  def initialize(input)
    raise 'This is an error.' unless Grade.valid_grade?(input)
    mark = input.to_s.split('.').first.downcase
    mark = Grade.to_letter(mark) if mark[/[0-9]/]
    @mark = mark
  end

  def inspect
    @mark
  end

  def ==(other)
    self.to_s == other.to_s.downcase
  end

  def <=>(other)
    order = %w(f- f f+ d- d d+ c- c c+ b- b b+ a- a a+)
    order.index(other.mark) <=> order.index(self.mark)
  end
end
