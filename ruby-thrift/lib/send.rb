require "tackle"
require_relative "rthrift"

message         = Message.new
message.url     = "http://localhost"
message.payload = "Hi from Ruby!"

binary = RThrift.serialize(message)

options = {
  :url         => "amqp://localhost",
  :exchange    => "elixir-exchange",
  :routing_key => "elixir-messages"
}

Tackle.publish(binary, options)
