require "tackle"
require "thrift_serializer"

$:.push("gen-rb")
require "models_constants"

options = {
  :url         => "amqp://localhost",
  :exchange    => "ruby-exchange",
  :routing_key => "ruby-messages",
  :queue       => "ruby-queue"
}

Tackle.subscribe(options) do |raw_message|
  user = ThriftSerializer.decode(raw_message, User.new)
  puts "Name: #{user.name}\nAge: #{user.age}"
end
