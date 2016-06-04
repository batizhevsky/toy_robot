module ToyRobot
  class Robot
    ALLOWED_DIRECTIONS = [:north, :east, :south, :west].freeze

    def initialize
      @placed = false
    end

    def direction
      check_placed!

      @direction
    end

    def place(direction)
      turn_on(direction)
      @placed = true
    end

    def right
      check_placed!

      current_index = ALLOWED_DIRECTIONS.index(direction)
      if ALLOWED_DIRECTIONS.size == current_index + 1
        turn_on ALLOWED_DIRECTIONS.first
      else
        turn_on ALLOWED_DIRECTIONS[current_index + 1]
      end
    end

    def left
      check_placed!

      current_index = ALLOWED_DIRECTIONS.index(direction)
      if current_index == 0
        turn_on ALLOWED_DIRECTIONS.last
      else
        turn_on ALLOWED_DIRECTIONS[current_index - 1]
      end
    end

    def calculate_move(current_x, current_y)
      check_placed!

      case direction
      when :north
        current_x += 1
      when :east
        current_y += 1
      when :south
        current_x -= 1
      when :west
        current_y -= 1
      else
        raise 'Never will be executed'
      end
      [current_x, current_y]
    end

    private

    def turn_on(direction)
      raise UnknownDirection unless ALLOWED_DIRECTIONS.include?(direction)

      @direction = direction
    end

    def check_placed!
      raise RobotNotPlaced unless @placed
    end
  end
end
