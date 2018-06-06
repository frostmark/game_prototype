module Game
  class Platform
    attr_reader :x, :speed

    DEFAULT_X = 0.5
    DEFAULT_SPEED = 0.01

    def initialize(x: DEFAULT_X, speed: DEFAULT_SPEED)
      @x = x
      @speed = speed
    end

    def move_left
      @x = @x - @speed
    end

    def move_right
      @x = @x + @speed
    end
  end
end
