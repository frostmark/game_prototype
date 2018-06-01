require 'space_elevator'
require 'eventmachine'
require 'em-websocket-client'

EventMachine.run do
  url = 'ws://127.0.0.1:3000/cable'

  client = SpaceElevator::Client.new(url) do
    puts 'Disconnected. Exiting...'
    EventMachine.stop_event_loop
  end

  puts client.inspect

  client.connect do |msg|
    puts msg
    client.subscribe(channel: 'GameChannel', room: 'room') do |chat|
      puts chat.inspect
      client.publish(chat['identifier'], 'test')
    end
  end
end


# require 'space_elevator'
# require 'eventmachine'
# require 'em-websocket-client'
# require 'json'

# # Килиент который совершает звонок
# # Шаги:
# #   1. Вызов второго участника
# #   2. Получает уведомление, что второй участник взял трубку
#
# EventMachine.run do
#   url = 'ws://localhost:3000/cable'
#
#   client = SpaceElevator::Client.new(url) do
#     puts 'Disconnected. Exiting...'
#     EventMachine.stop_event_loop
#   end
#
#   client.connect do |msg|
#     case msg['type']
#     when 'welcome'
#       client.subscribe(channel: 'LabWorkAssignmentPhoneChannel', id: 22) do |chat|
#         if chat['type'] == 'confirm_subscription'
#           request = {
#             action: 'get_list'
#           }
#           puts 'Action: get_list'
#           client.publish(chat['identifier'], request)
#         end
#
#         if chat['message']
#           if chat['message']['action'] == 'list_phones'
#             request = {
#               action: 'request',
#               to: 1288,
#               from: 1288,
#               status: 'call'
#             }
#
#             puts 'List phones'
#             puts chat['message']
#             client.publish(chat['identifier'], request)
#
#           end
#
#           puts 'busy' if chat['message']['status'] == 'busy'
#         end
#       end
#     when 'ping'
#
#     else
#       puts msg
#     end
#   end
# end
