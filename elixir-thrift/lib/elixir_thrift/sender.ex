defmodule ElixirThrift.Sender do

  @options  %{
    url: "amqp://localhost",
    exchange: "ruby-exchange",
    routing_key: "ruby-messages",
  }

  def send do

    IO.puts "A message is being sent"

    ElixirThrift.Struct.User.new(name: "Wade Winston Wilson", age: 25)
    |> ElixirThrift.Binary.elixir_to_binary({:struct, {:models_types, :User}})
    |> Tackle.publish(@options)

    {:ok}
  end

end
