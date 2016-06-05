module ToyRobot
  class Table
    def initialize(x, y, size: 5)
      @x, @y = x, y
      @size = size

      check_range(x, y)
    end

    def move_to(direction)
      move_x, move_y = @x, @y
      case direction
      when :north
        move_x += 1
      when :east
        move_y += 1
      when :south
        move_x -= 1
      when :west
        move_y -= 1
      else
        raise 'will never be executed'
      end

      check_range(move_x, move_y)

      @x, @y = move_x, move_y
    end

    # @return [Array] return a position array with x and y coord
    def current_position
      [@x, @y]
    end

    private

    def can_placed?(x, y)
      positive?(x) &&
        positive?(y) &&
        x < @size &&
        y < @size
    end

    def positive?(value)
      value >= 0
    end

    def check_range(x, y)
      raise OutOfTable unless can_placed?(x, y)
    end
  end
end
