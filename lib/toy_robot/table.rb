module ToyRobot
  class Table
    def initialize(size: 5)
      @size = size
      @x = 0
      @y = 0
    end

    def move_to(x, y)
      raise OutOfTable unless can_placed?(x, y)
      @x = x
      @y = y
    end

    # @return [Array] return a position array with x and y coord
    def current_position
      [@x, @y]
    end

    def can_placed?(x, y)
      positive?(x) &&
        positive?(y) &&
        x < @size &&
        y < @size
    end

    private

    def positive?(value)
      value >= 0
    end
  end
end
