class GameChannel < ApplicationCable::Channel
  def subscribed
    @@platform ||= ::Game::Platform.new
    @@ball ||= ::Game::Ball.new

    stream_from 'test'
    @@real_time ||= real_time
  end

  def received(data)
  end

  def platform_right
    @@platform.move_right
  end

  def platform_left
    @@platform.move_left
  end

  def real_time
    Thread.new do
      loop do
        @@ball.run
        ActionCable.server.broadcast "test", {
          platform: {
            position: {
              x: @@platform.x
            }
          },
          ball: {
            position: {
              x: @@ball.x,
              y: @@ball.y
            }
          }
        }
      end
    end
  end
end
