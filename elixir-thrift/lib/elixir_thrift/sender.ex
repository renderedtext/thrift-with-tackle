defmodule ElixirThrift.Sender do

  @options  %{
    url: "amqp://localhost",
    exchange: "elixir-exchange",
    routing_key: "elixir-messages",
  }

  def send do

    IO.puts "A message is being sent"

    ElixirThrift.Struct.Message.new(url: "neki http", payload: "ovo je neki tovar")
    |> ElixirThrift.Binary.elixir_to_binary({:struct, {:models_types, :Message}})
    |> Tackle.publish(@options)

    {:ok}
  end

end
