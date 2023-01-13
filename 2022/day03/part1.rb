rucksacks = File.readlines 'input.txt', chomp: true

puts rucksacks.map { |rucksack|
  middle = rucksack.length / 2
  first_compartment, second_compartment = rucksack[0...middle], rucksack[middle..-1]
  duplicates = first_compartment.chars & second_compartment.chars
  priority_map = ('a'..'z').to_a + ('A'..'Z').to_a
  priority = ->(char) { priority_map.index(char) + 1 }
  priority[duplicates.first]
}.sum
