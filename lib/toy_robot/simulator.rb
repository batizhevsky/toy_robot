require_relative 'errors'

module ToyRobot
  class Simulator

    def initialize(robot:, table:)
      @robot = robot
      @table = table
      @placed = false
    end

    def place(x, y, orientation)
      put_on_table(x,y)
      turn_on(orientation)

      @placed = true
    end

    def report
      @table.current_position << @robot.direction
    end

    def move
      position = @table.current_position

      next_x, next_y = @robot.calculate_move(*position)

      @table.move_to(next_x, next_y)
    end

    def right
      @robot.right
    end

    def left
      @robot.left
    end

    private

    def put_on_table(x,y)
      @table.move_to(x, y)
    end

    def turn_on(orientation)

      @robot.place(orientation)
    end
  end
end
