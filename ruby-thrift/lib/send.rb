require "tackle"
require "thrift_serializer"

$:.push("gen-rb")
require "models_constants"

user      = User.new
user.name = "John Smith"
user.age  = 42

binary = ThriftSerializer.encode(user)

options = {
  :url         => "amqp://localhost",
  :exchange    => "elixir-exchange",
  :routing_key => "elixir-messages"
}

Tackle.publish(binary, options)
