require_relative 'errors'

module ToyRobot
  class Simulator
    def place(x, y, orientation)
      put_on_table(x,y)
      turn_on(orientation)
      true
    end

    def report
      table.current_position << robot.direction
    end

    def move
      direction = robot.direction
      table.move_to(direction)
    end

    def right
     robot.right
    end

    def left
     robot.left
    end

    private

    def put_on_table(x,y)
      @table = Table.new(x, y)
    end

    def turn_on(orientation)
      @robot = Robot.new(orientation)
    end

    def robot
      @robot || notify_placed
    end

    def table
      @table || notify_placed
    end

    def notify_placed
      raise RobotNotPlaced, 'Please place a robot to start'
    end
  end
end
