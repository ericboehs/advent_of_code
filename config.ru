require 'bundler/setup'
require_relative './day_1'

def path
  @path ||= DayOne::Path.new(%w[
    R1 R3 L2 L5 L2 L1 R3 L4 R2 L2 L4 R2 L1 R1 L2 R3 L1 L4 R2 L5 R3 R4 L1 R2 L1 R3 L4 R5 L4 L5 R5 L3 R2 L3
    L3 R1 R3 L4 R2 R5 L4 R1 L1 L1 R5 L2 R1 L2 R188 L5 L3 R5 R1 L2 L4 R3 R5 L3 R3 R45 L4 R4 R72 R2 R3 L1 R1
    L1 L1 R192 L1 L1 L1 L4 R1 L2 L5 L3 R5 L3 R3 L4 L3 R1 R4 L2 R2 R3 L5 R3 L1 R1 R4 L2 L3 R1 R3 L4 L3 L4
    L2 L2 R1 R3 L5 L1 R4 R2 L4 L1 R3 R3 R1 L5 L2 R4 R4 R2 R1 R5 R5 L4 L1 R5 R3 R4 R5 R3 L1 L2 L4 R1 R4 R5
    L2 L3 R4 L4 R2 L2 L4 L2 R5 R1 R4 R3 R5 L4 L4 L5 L5 R3 R4 L1 L3 R2 L2 R1 L3 L5 R5 R5 R3 L4 L2 R4 R5 R1
    R4 L3
  ])
end

def answer_1
  path.shortest
end

def answer_2
  coordinate = path.first_coordinates_revisited
  DayOne::Path.distance_traveled_for_coordinates coordinate
end

def html
  "<h1>Answer 1: #{answer_1}</h1>" +
  "<h1>Answer 2: #{answer_2}</h1>"
end

run ->(env) { [200, {"Content-Type" => "text/html"}, [html]] }
