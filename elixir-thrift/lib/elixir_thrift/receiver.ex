defmodule ElixirThrift.Receiver do
  use Tackle.Consumer,
    url: "amqp://localhost",
    exchange: "elixir-exchange",
    routing_key: "elixir-messages",
    service: "elixir-service"

  def handle_message(message) do
    IO.puts "A message arrived. Life is good!"

    {:ok ,debinarized_message} = ElixirThrift.Binary.binary_to_elixir(message, {:struct, {:models_types, :Message}})

    IO.inspect debinarized_message

    {:ok}
  end

end
