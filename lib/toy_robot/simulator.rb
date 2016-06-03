require_relative 'errors'

module ToyRobot
  class Simulator
    ALLOWED_DIRECTIONS = [:north, :east, :south, :west].freeze
    attr_reader :direction

    def initialize(robot:, table:)
      @robot = robot
      @table = table
      @x
      @y
      @placed = false
    end

    def place(x, y, orientation)
      put_on_table(x,y)
      turn_on(orientation)
      @placed = true
    end

    def report
      check_if_paced
      [@x, @y, direction].freeze
    end

    def move
      check_if_paced
      
      next_x, next_y = @x, @y
      case direction
      when :north
        next_x += 1
      when :east
        next_y += 1
      when :south
        next_x -= 1
      when :west
        next_y -= 1
      else
        raise 'Never will be executed'
      end
      

      if @table.can_placed?(next_x, next_y)
        @x, @y = next_x, next_y
      else
        raise ProhibitedStep
      end
    end

    def right
      check_if_paced

      current_index = ALLOWED_DIRECTIONS.index(direction)
      if ALLOWED_DIRECTIONS.size == current_index + 1
        turn_on ALLOWED_DIRECTIONS.first
      else
        turn_on ALLOWED_DIRECTIONS[current_index + 1]
      end
    end

    def left
      check_if_paced

      current_index = ALLOWED_DIRECTIONS.index(direction)
      if current_index == 0
        turn_on ALLOWED_DIRECTIONS.last
      else
        turn_on ALLOWED_DIRECTIONS[current_index - 1]
      end
    end

    private

    def put_on_table(x,y)
      if @table.can_placed?(x,y)
        @x = x
        @y = y
      else
        raise OutOfTable
      end
    end

    def turn_on(orientation)
      if ALLOWED_DIRECTIONS.include? orientation
        @direction = orientation
      else
        raise UnknownDirection
      end
    end

    def check_if_paced
      raise RobotNotPlaced unless @placed
    end
  end
end
