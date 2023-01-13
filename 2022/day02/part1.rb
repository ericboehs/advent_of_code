lines = File.readlines('input.txt', chomp: true)
total_score = lines.map do |line|
  opponent, mine = line.split ' '

  opponent =
    if opponent == 'A'
      'Rock'
    elsif opponent == 'B'
      'Paper'
    elsif opponent == 'C'
      'Scissors'
    end

  mine =
    if mine == 'X'
      'Rock'
    elsif mine == 'Y'
      'Paper'
    elsif mine == 'Z'
      'Scissors'
    end

  shape_score =
    if mine == 'Rock'
      1
    elsif mine == 'Paper'
      2
    elsif mine == 'Scissors'
      3
    end

  case [opponent, mine]
  when ['Rock', 'Rock'], ['Paper', 'Paper'], ['Scissors', 'Scissors']
    shape_score + 3
  when ['Rock', 'Paper'], ['Paper', 'Scissors'], ['Scissors', 'Rock']
    shape_score + 6
  when ['Rock', 'Scissors'], ['Paper', 'Rock'], ['Scissors', 'Paper']
    shape_score
  end
end.sum

puts total_score
