require "tackle"
require_relative "rthrift"

options = {
  :url         => "amqp://localhost",
  :exchange    => "ruby-exchange",
  :routing_key => "ruby-messages",
  :queue       => "ruby-queue"
}

Tackle.subscribe(options) do |raw_message|
  message = RThrift.deserialize(raw_message)
  puts "URL: #{message.url}\nPaylod: #{message.payload}"
end
