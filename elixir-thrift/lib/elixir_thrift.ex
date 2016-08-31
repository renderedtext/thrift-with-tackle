defmodule ElixirThrift do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      worker(ElixirThrift.Receiver, [], [restart: :permanent, shutdown: :infinity])
    ]

    opts = [strategy: :one_for_one, name: ElixirThrift.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
