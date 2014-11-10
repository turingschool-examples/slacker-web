require 'faye'
require 'eventmachine'
require 'em-hiredis'
require 'json'


begin
  puts "You're listening on Slacker and publishing to the web."
  puts "Press Ctrl-C at any time to exit.\n"
  
  EventMachine.run do
    redis = EM::Hiredis.connect(ENV['SLACKER_REDIS'])
    pubsub = redis.pubsub
  
    client = Faye::Client.new('http://localhost:9292/faye')
    pubsub.subscribe(:community)
  
    pubsub.on(:message) do |channel, message|
      data = JSON.parse(message)
      formatted_message = { author: data['user'],  body: data['msg'] }
      client.publish('/messages', formatted_message.to_json)
    end
  end
  
rescue Interrupt => e
  puts "\nGoodbye..."
end