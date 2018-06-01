class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'test'
  end

  def received(data)
    GameChannel.broadcast_to('room', {test: 1})
  end

  def test
    puts 1234
  end

  def unsubscribed
    puts 1
  end
end
