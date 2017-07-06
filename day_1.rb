# The first day in the Advent of Code challenges
module DayOne
  # Represents the path to the Easter Bunny Headquarters as intercepted by the Elves
  class Path
    # The four directions of a compass ordered clockwise. Used to determine our heading based on relative
    # directions (i.e. left and right)
    CARDINAL_DIRECTIONS = %w[N E S W]

    # @return [Array] Input path you'd like to optimize. Each element contains a string with the relative
    # direction and the distance (e.g. L1 or R22)
    attr_reader :directions

    # @param coordinates [Array] The latitude and longitude of your position relative to your starting
    # position (0, 0)
    # @return [Integer] The rectilinear distance traveled from 0, 0
    def self.distance_traveled_for_coordinates coordinates
      coordinates.map(&:abs).sum
    end

    # Computes the distance traveled from a starting point and reveals the first coordinate you revisited.
    #
    # @param directions [Array] All of the directions from the Easter Bunny Recruiting Document
    # @see Path#directions
    def initialize directions
      self.directions = directions
      self.current_direction = 'N'
      self.current_coordinates = [0, 0]
      self.previous_coordinates = []

      travel
    end

    # @return [Integer] Rectilinear distance traveled from 0, 0 for this Path
    def shortest
      self.class.distance_traveled_for_coordinates current_coordinates
    end

    # @return [Array] Revisited coordinates from 0, 0
    def first_coordinates_revisited
      previous_coordinates.detect { |coordinates| previous_coordinates.count(coordinates) > 1 }
    end

    private

    attr_accessor :current_direction
    attr_accessor :current_coordinates
    attr_accessor :previous_coordinates

    def directions= directions
      @directions = directions.map do |segment|
        { direction: segment[0], distance: segment[1..-1].to_i }
      end
    end

    def travel
      @travel ||= directions.each do |segment|
        turn segment[:direction]
        step segment[:distance]
      end
    end

    def turn relative_direction
      self.current_direction =
        if relative_direction == "L"
          CARDINAL_DIRECTIONS[current_direction_index - 1]
        else
          CARDINAL_DIRECTIONS[current_direction_index + 1] || 'N'
        end
    end

    def step distance
      distance.times do
        increment_latitude  if current_direction == 'N'
        increment_longitude if current_direction == 'E'
        decrement_latitude  if current_direction == 'S'
        decrement_longitude if current_direction == 'W'
        save_current_coordinates
      end
    end

    def increment_latitude
      self.current_coordinates = [current_coordinates[0] + 1, current_coordinates[1]]
    end

    def decrement_latitude
      self.current_coordinates = [current_coordinates[0] - 1, current_coordinates[1]]
    end

    def increment_longitude
      self.current_coordinates = [current_coordinates[0], current_coordinates[1] + 1]
    end

    def decrement_longitude
      self.current_coordinates = [current_coordinates[0], current_coordinates[1] - 1]
    end

    def save_current_coordinates
      self.previous_coordinates = previous_coordinates << current_coordinates
    end

    def current_direction_index
      CARDINAL_DIRECTIONS.index current_direction
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
      assert_equal 307, path.shortest
    end

    def test_visit_coordinates_twice
      coordinate = path.first_coordinates_revisited
      distance = DayOne::Path.distance_traveled_for_coordinates coordinate
      assert_equal 165, distance
    end
  end
end


__END__
--- Day 1: No Time for a Taxicab ---

Santa's sleigh uses a very high-precision clock to guide its movements, and the clock's oscillator is
regulated by stars. Unfortunately, the stars have been stolen... by the Easter Bunny. To save Christmas, Santa
needs you to retrieve all fifty stars by December 25th.

Collect stars by solving puzzles. Two puzzles will be made available on each day in the advent calendar; the
second puzzle is unlocked when you complete the first. Each puzzle grants one star. Good luck!

You're airdropped near Easter Bunny Headquarters in a city somewhere. "Near", unfortunately, is as close as
you can get - the instructions on the Easter Bunny Recruiting Document the Elves intercepted start here, and
nobody had time to work them out further.

The Document indicates that you should start at the given coordinates (where you just landed) and face North.
Then, follow the provided sequence: either turn left (L) or right (R) 90 degrees, then walk forward the given
number of blocks, ending at a new intersection.

There's no time to follow such ridiculous instructions on foot, though, so you take a moment and work out the
destination. Given that you can only walk on the street grid of the city, how far is the shortest path to the
destination?

For example:

Following R2, L3 leaves you 2 blocks East and 3 blocks North, or 5 blocks away.
R2, R2, R2 leaves you 2 blocks due South of your starting position, which is 2 blocks away.
R5, L5, R5, R3 leaves you 12 blocks away.

How many blocks away is Easter Bunny HQ?

Your puzzle answer was 307.

The first half of this puzzle is complete! It provides one gold star: *

--- Part Two ---

Then, you notice the instructions continue on the back of the Recruiting Document. Easter Bunny HQ is actually
at the first location you visit twice.

For example, if your instructions are R8, R4, R4, R8, the first location you visit twice is 4 blocks away, due
East.

How many blocks away is the first location you visit twice?
