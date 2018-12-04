def parse_claim claim
  claim_id, coords_with_dimensions = claim.split ' @ '   # => ["#1", "123,456: 10x11"]
  coords, dimensions = coords_with_dimensions.split ': ' # => ["123,456", "10x11"] 
  x, y = coords.split(',').map(&:to_i)                   # => [123, 456]
  width, height = dimensions.split('x').map(&:to_i)      # => [10, 11]

  [claim_id, x, y, width, height]
end

claims = File.readlines 'day03.in', chomp: true
fabric = Hash.new 0
answer = nil

claims.each do |claim|
  _claim_id, x, y, width, height = parse_claim claim

  width.times do |x_offset|
    height.times do |y_offset|
      fabric[[x + x_offset, y + y_offset]] += 1
    end
  end
end

claims.each do |claim|
  claim_id, x, y, width, height = parse_claim claim

  does_not_overlap = true 

  width.times do |x_offset|
    height.times do |y_offset|
      does_not_overlap = false if fabric[[x + x_offset, y + y_offset]] > 1
    end
  end

  answer = claim_id if does_not_overlap
end

puts answer

system "echo #{answer} | pbcopy"

__END__
--- Part Two ---

  Amidst the chaos, you notice that exactly one claim doesn't overlap by even a single square inch of fabric with any other claim. If you can somehow draw attention to it, maybe the Elves will be able to make Santa's suit after all!

For example, in the claims above, only claim 3 is intact after all claims are made.

  What is the ID of the only claim that doesn't overlap?

Your puzzle answer was 504.
