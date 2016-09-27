defmodule ElixirThrift.Models do
  use Riffed.Struct, models_types: [:User]
  use ThriftSerializer
end
