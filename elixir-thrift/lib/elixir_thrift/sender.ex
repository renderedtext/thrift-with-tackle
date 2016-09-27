defmodule ElixirThrift.Sender do

  @options  %{
    url: "amqp://localhost",
    exchange: "ruby-exchange",
    routing_key: "ruby-messages",
  }

  def send do
    IO.puts "A message is being sent"

    ElixirThrift.Models.User.new(name: "Wade Winston Wilson", age: 25)
    |> ElixirThrift.Models.encode(model: ElixirThrift.Models.User)
    |> Tackle.publish(@options)

    {:ok}
  end

end
