# differ by exactly one character at the same position in both strings

def off_by_one? str1, str2
  str1.chars.map.with_index { |char, i| char != str2[i] }.select(&:itself).count == 1
end

def matching_letters str1, str2
  str1.chars.map.with_index { |char, i| char if char == str2[i] }.compact.join
end

box_ids = File.readlines 'day02.in', chomp: true

answer =
  box_ids.flat_map do |box_id|
    box_ids.flat_map do |other_box_id|
      next unless off_by_one? box_id, other_box_id
      matching_letters box_id, other_box_id
    end
  end.compact.first

puts answer

system "echo #{answer} | pbcopy"

__END__
--- Part Two ---

Confident that your list of box IDs is complete, you're ready to find the boxes full of prototype fabric.

The boxes will have IDs which differ by exactly one character at the same position in both strings. For example, given the following box IDs:

abcde
fghij
klmno
pqrst
fguij
axcye
wvxyz
The IDs abcde and axcye are close, but they differ by two characters (the second and fourth). However, the IDs fghij and fguij differ by exactly one character, the third (h and u). Those must be the correct boxes.

What letters are common between the two correct box IDs? (In the example above, this is found by removing the differing character from either ID, producing fgij.)
