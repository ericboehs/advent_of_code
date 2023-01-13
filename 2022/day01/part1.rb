# read the contents of the file into a variable
lines = File.readlines('input.txt', chomp: true)

# Convert empty lines into nil

# Convert strings to numbers
lines = lines.map do |line|
  line.to_i
end

# Convert 0 lines into nil
lines = lines.map do |line|
  if line == 0
    nil
  else
    line
  end
end

# split the file by blank lines.
lines = lines.slice_before{ |e| e.nil? }.map(&:compact)

# add elf numbers for each backpack.
backpacks = {}
lines.each.with_index do |line, i|
  backpacks[i+1] = line
end

# sum the backpacks for each elf.
backpacks.each do |elf, backpack|
  backpacks[elf] = backpack.sum
end

# sort the elves backpacks from largest to smallest.
backpacks = backpacks.sort_by(&:last)

last_three = backpacks.last(3).map(&:last)
puts last_three.last
# puts last_three.sum
