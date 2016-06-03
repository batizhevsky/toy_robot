module ToyRobot
  class Table
    def initialize(size: 5)
      @size = size
    end

    def can_placed?(x,y)
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
