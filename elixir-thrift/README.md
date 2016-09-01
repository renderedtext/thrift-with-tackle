# Elixir-thrift

Test application for implementing thrift while using elixir. Comes in pair with an another ruby application, which is also using thrift.

## Getting started

Thrift must be installed and the following is added to the mix.exs:
```elixir
def project do
  [compilers: [:thrift | Mix.compilers],
  thrift_files: Mix.Utils.extract_files(["thrift"], [:thrift])]
end

def application do
  [applications:
    [:tackle,
     :riffed]
  ]
end

defp deps do
  [ {:tackle, github: "renderedtext/ex-tackle"},
    {:riffed, github: "pinterest/riffed", tag: "1.0.0", submodules: true} ]
end
```

## Model

The model that contains the Thrift structs can be found in the ```thrift/models.thrift``` file and a basic thrift struct looks something like this:

```thrift
struct User {
  1: string name
  2: i32 age
}
```

## Working with structs

To work with structs defined in the model a seperate module must be defined, looking something like this:

```elixir
defmodule ElixirThrift.Struct do
  use Riffed.Struct, models_types: [:User]
end
```

Notice that it says **models_types**. The part before *_types* must match the name of the *.thrift* file in the ```thrift``` folder of the project.

To create a new instance of a struct, do this:
```elixir
ElixirThrift.Struct.User.new(name: "Wade Winston Wilson", age: 25)
```
This would be an equivalent of:
```
%ElixirThrift.Struct.User{age: 25, name: "Wade Winston Wilson"}
```


## Serialization

The serialization and deserialization of messages are done by the following functions, which can be found in the ```ElixirThrift.Binary``` module:

```elixir

#converts from binary to elixir using a Thrift struct definition
#struct_definition should look something like this: {:struct, {:models_types, :User}}
def binary_to_elixir(record_binary, struct_definition) do
  try do

    with({:ok, memory_buffer_transport} <- :thrift_memory_buffer.new(record_binary),
         {:ok, binary_protocol} <- :thrift_binary_protocol.new(memory_buffer_transport),
         {_, {:ok, record}} <- :thrift_protocol.read(binary_protocol, struct_definition)) do

           {:ok, ElixirThrift.Struct.to_elixir(record, struct_definition)}

    end

  rescue _ ->
      IO.puts "Cant decode"
      {:error, :cant_decode}
  end
end

#converts from elixir to binary using a Thrift struct definition
#struct_definition should look something like this: {:struct, {:models_types, :User}}
def elixir_to_binary(struct_to_binarise, struct_definition) do
    with({:ok, tf} <- :thrift_memory_buffer.new_transport_factory(),
        {:ok, pf} <- :thrift_binary_protocol.new_protocol_factory(tf, []),
        {:ok, binary_protocol} <- pf.()) do

          proto = ElixirThrift.Struct.to_erlang(struct_to_binarise, struct_definition)
          |> write_proto(binary_protocol, struct_definition)

          {_, data} = :thrift_protocol.flush_transport(proto)
          :erlang.iolist_to_binary(data)
        end
end

defp write_proto(thrift_struct, protocol, struct_definition) do
  {proto, :ok} = :thrift_protocol.write(protocol, {struct_definition, thrift_struct})
  proto
end

```

## Sending and receiving

The sending and receiving of messages is done through ```ex-tackle``` in a standard way, using ```Tackle.publish``` and ```handle_message```. This can be done because stings are viewed as binary, so our serialized messages can be passed as arguments for the methods mentioned above.
