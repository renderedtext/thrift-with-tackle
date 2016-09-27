defmodule ElixirThrift.Receiver do
  use Tackle.Consumer,
    url: "amqp://localhost",
    exchange: "elixir-exchange",
    routing_key: "elixir-messages",
    service: "elixir-service"

  def handle_message(message) do
    IO.puts "A message arrived. Life is good!"

    decoded_message = ElixirThrift.Models.decode(message, model: ElixirThrift.Models.User)

    IO.inspect decoded_message
  end

end
