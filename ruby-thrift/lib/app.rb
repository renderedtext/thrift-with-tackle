module App
  require_relative "app/consumer"

  options = {
    :url         => "amqp://localhost",
    :exchange    => "ruby-exchange",
    :routing_key => "ruby-messages",
    :queue       => "ruby-queue"
  }

  Consumer.subscribe(options)

end
