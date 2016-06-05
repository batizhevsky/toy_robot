module ToyRobot
  class Robot
    ALLOWED_DIRECTIONS = [:north, :east, :south, :west].freeze

    def initialize(direction)
      @direction = direction

      check_direction(direction)
    end

    def direction
      @direction
    end

    def right
      current_index = ALLOWED_DIRECTIONS.index(direction)
      if ALLOWED_DIRECTIONS.size == current_index + 1
        turn_on ALLOWED_DIRECTIONS.first
      else
        turn_on ALLOWED_DIRECTIONS[current_index + 1]
      end
    end

    def left
      current_index = ALLOWED_DIRECTIONS.index(direction)
      if current_index == 0
        turn_on ALLOWED_DIRECTIONS.last
      else
        turn_on ALLOWED_DIRECTIONS[current_index - 1]
      end
    end

    private

    def turn_on(direction)
      check_direction(direction)

      @direction = direction
    end

    def check_direction(direction)
      raise UnknownDirection unless ALLOWED_DIRECTIONS.include?(direction)
    end
  end
end
