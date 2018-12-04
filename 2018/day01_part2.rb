frequency = 0
answers = Hash.new 0
changes = File.readlines 'day01.in'

loop do
  changes.each do |change|
    frequency += change.to_i
    answers[frequency] += 1
    return puts frequency if answers[frequency] == 2
  end
end
