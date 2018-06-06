module Game
  class Ball
    attr_reader :x, :y, :speed

    DEFAULT_X = 0
    DEFAULT_Y = 0
    DEFAULT_SPEED = 0.001

    def initialize(x: DEFAULT_X, y: DEFAULT_Y, speed: DEFAULT_SPEED)
      @x = x
      @y = y

      @directions = {
        x: 1,
        y: 0.8
      }

      @speed = speed
    end

    def run
      @directions[:x] = -@directions[:x] if @x >= 1 || @x < 0
      @directions[:y] = -@directions[:y] if @y >= 1 || @y < 0

      @x = x + @speed * @directions[:x]
      @y = y + @speed * @directions[:y]
    end
  end
end
