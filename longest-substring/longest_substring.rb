# Implement an algorithm that when given a string,
# returns the longest repeating substring found in the input.

# E.g., in the string "phenomenal", the longest repeating substring is "en".

# Part of this work is to be able to talk about algorithmic complexity.

# This particular problem has quite a few different solutions,
# and each of them have trade-offs in both time and memory costs.

#############################################################

# Right now, if you have "red blue blue red" it returns " blue " as the output.
# Note the overlapping spaces

# Also note that the "longest_repeat" method works on arrays as well as strings.

# This also does needless work (unless I am mistaken) in two places (if not more):

#    1. In the string "abcdef zz abcdef" a single pass can show that checking for
#       example, from "c" is unnecessary due to "b" preceding both "c"s, so they are
#       guaranteed to part of a larger repeated substring that will already be checked.

#    2. The line where new_indices is created, a potentially large slice
#      of the input is taken. This might only need to look at the new
#      section, as the previous sections should already be valid.

# Anyway, room for improvment. After the interview I will just google how this
# is really done and see if I am barking up the wrong tree.

#############################################################

def nonuniq(list, &block)
  block ||= proc { |x| x }
  groups = list.group_by(&block)
  groups.select { |_, v| v.count > 1 }.values.flatten
end

def longest_repeat(input, indices = (0..input.length), len = 1)
  new_indices = nonuniq(indices) { |i| input.slice(i, len) }
  return input.slice(indices.first, len - 1) if new_indices.empty?
  longest_repeat(input, new_indices, len + 1)
end

#############################################################

puts 'The longest (repeated) substring of "phenomenal" is:'
puts longest_repeat('phenomenal')
#=> 'en'

#############################################################

require('open-uri')

dune_txt = open('http://www.glozman.com/TextPages/Frank%20Herbert%20-%20Dune.txt').read
dune_words = dune_txt.split(/[\s\"-]/)

puts 'The longest substring in the novel "Dune" is:'
puts longest_repeat(dune_words).join(' ')
#=> Fear is the mind killer. Fear is the little death that brings total obliteration. I will face my fear. I will permit it to pass over me and through me. And when it has gone past

# This takes about 5 seconds to do the 'longest_repeat' part,
# about 12 if words are not split up.

# It is about 4 seconds for one million random letters ('a'..'z')
# and 10 seconds for a-d (though googling seems to show DNA being non-random).
# https://en.wikipedia.org/wiki/Compression_of_Genomic_Re-Sequencing_Data
