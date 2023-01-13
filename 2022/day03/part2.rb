rucksacks = File.readlines 'input.txt', chomp: true

elf_groups = rucksacks.each_slice(3).to_a

puts elf_groups.map { |elf_group|
  duplicates = elf_group[0].chars & elf_group[1].chars & elf_group[2].chars
   priority_map = ('a'..'z').to_a + ('A'..'Z').to_a
   priority = ->(char) { priority_map.index(char) + 1 }
   priority[duplicates.first]
}.sum
