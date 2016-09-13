require "tackle"
require_relative "rthrift"

user      = User.new
user.name = "John Smith"
user.age  = 42

binary = RThrift.serialize(user)

options = {
  :url         => "amqp://localhost",
  :exchange    => "elixir-exchange",
  :routing_key => "elixir-messages"
}

Tackle.publish(binary, options)
