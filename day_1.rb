module DayOne
  class Path
    CARDINAL_DIRECTIONS = %w[N E S W]
    # @return [Array] Input path you'd like to optomize as direction, distance characters (e.g. L1 or R2)
    attr_reader :input_path

    # @return [String] Current direction we are traveling (e.g. 'N')
    attr_accessor :current_cardinal_direction

    # @return [Hash] Distance traveled in each direction
    attr_accessor :distance_traveled

    attr_accessor :previous_coordinates
    attr_accessor :current_coordinates

    def initialize input_path
      @input_path = input_path.map { |ip| { direction: ip[0], distance: ip[1..-1] } }
      @distance_traveled = Hash.new 0
      @current_cardinal_direction = 'N'
      @current_coordinates = [0, 0]
      @previous_coordinates = []
    end

    def shortest
      travel
      distance_traveled['N'] - distance_traveled['S'] + distance_traveled['E'] - distance_traveled['W']
    end

    private

    def travel
      @travel ||= input_path.each do |step|
        turn step[:direction]
        step[:distance].to_i.times do
          if current_cardinal_direction == 'N'
            self.current_coordinates = [current_coordinates[0] + 1, current_coordinates[1]]
          elsif current_cardinal_direction == 'E'
            self.current_coordinates = [current_coordinates[0], current_coordinates[1] + 1]
          elsif current_cardinal_direction == 'S'
            self.current_coordinates = [current_coordinates[0] - 1, current_coordinates[1]]
          elsif current_cardinal_direction == 'W'
            self.current_coordinates = [current_coordinates[0], current_coordinates[1] - 1]
          end
          self.previous_coordinates << current_coordinates
        end
        step step[:distance]
      end
    end

    def turn relative_direction
      if relative_direction == "L"
        self.current_cardinal_direction = CARDINAL_DIRECTIONS[current_cardinal_direction_index - 1]
      else
        self.current_cardinal_direction = CARDINAL_DIRECTIONS[current_cardinal_direction_index + 1] || 'N'
      end
    end

    def step distance
      self.distance_traveled[current_cardinal_direction] += distance.to_i
    end

    def current_cardinal_direction_index
      CARDINAL_DIRECTIONS.index current_cardinal_direction
    end
  end
end

require 'minitest/autorun'

module DayOne
  class PathTest < MiniTest::Test
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

    def test_shortest_distance
      puts path.shortest
      assert_equal 307, path.shortest
    end

    def test_visit_coordinate_twice
      path.shortest
      coordinate = path.previous_coordinates.detect { |e| path.previous_coordinates.count(e) > 1 }
      puts coordinate.map(&:abs).sum
      assert_equal 165, coordinate.map(&:abs).sum
    end
  end
end


__END__
--- Day 1: No Time for a Taxicab ---

Santa's sleigh uses a very high-precision clock to guide its movements, and the clock's oscillator is regulated by stars. Unfortunately, the stars have been stolen... by the Easter Bunny. To save Christmas, Santa needs you to retrieve all fifty stars by December 25th.

Collect stars by solving puzzles. Two puzzles will be made available on each day in the advent calendar; the second puzzle is unlocked when you complete the first. Each puzzle grants one star. Good luck!

You're airdropped near Easter Bunny Headquarters in a city somewhere. "Near", unfortunately, is as close as you can get - the instructions on the Easter Bunny Recruiting Document the Elves intercepted start here, and nobody had time to work them out further.

The Document indicates that you should start at the given coordinates (where you just landed) and face North. Then, follow the provided sequence: either turn left (L) or right (R) 90 degrees, then walk forward the given number of blocks, ending at a new intersection.

There's no time to follow such ridiculous instructions on foot, though, so you take a moment and work out the destination. Given that you can only walk on the street grid of the city, how far is the shortest path to the destination?

For example:

Following R2, L3 leaves you 2 blocks East and 3 blocks North, or 5 blocks away.
R2, R2, R2 leaves you 2 blocks due South of your starting position, which is 2 blocks away.
R5, L5, R5, R3 leaves you 12 blocks away.

How many blocks away is Easter Bunny HQ?

Your puzzle answer was 307.

The first half of this puzzle is complete! It provides one gold star: *

--- Part Two ---

Then, you notice the instructions continue on the back of the Recruiting Document. Easter Bunny HQ is actually at the first location you visit twice.

For example, if your instructions are R8, R4, R4, R8, the first location you visit twice is 4 blocks away, due East.

How many blocks away is the first location you visit twice?
