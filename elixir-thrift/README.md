# Elixir-thrift

Test application for implementing thrift while using elixir. It comes in pair
with a ruby application, which is also using thrift.

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
     :thrift_serializer]
  ]
end

defp deps do
  [ {:tackle, github: "renderedtext/ex-tackle"},
    {:thrift_serializer, github: "renderedtext/ex-thrift-serializer"} ]
end
```

## Model

The model that contains the Thrift structs can be found in the
`thrift/models.thrift` file. A basic thrift struct looks something like this:

```thrift
struct User {
  1: string name
  2: i32 age
}
```

## Working with structs

To work with structs defined in the model a seperate module must be defined,
looking something like this:

```elixir
defmodule ElixirThrift.Models do
  use Riffed.Struct, models_types: [:User]
  use ThriftSerializer
end
```

Notice that it says **models_types**. The part before *_types* must match the
name of the *.thrift* file in the `thrift` folder of the project.

To create a new instance of a struct, do this:
```elixir
ElixirThrift.Models.User.new(name: "Wade Winston Wilson", age: 25)
```
This would be an equivalent of:
```
%ElixirThrift.Models.User{age: 25, name: "Wade Winston Wilson"}
```


## Serialization

The serialization and deserialization of messages are done by using the
`ex-thrift-serializer`, its functions `encode/2` and `decode/2` to be more
precise. </br>

To serialize an `User` thrift struct, do the following:
```elixir
message = ElixirThrift.Models.User.new(name: "Wade Winston Wilson", age: 25)
encoded_message = ElixirThrift.Models.encode(message,
                  model: ElixirThrift.Models.User)
```

To deserialize a previously serialized `User` thrift struct, do the following:
```elixir
decoded_message = ElixirThrift.Models.decode(message,
                  model: ElixirThrift.Models.User)
```

## Sending and receiving

The sending and receiving of messages is done through `ex-tackle` in a standard
way, using `Tackle.publish` and `handle_message`. This can be done because
strings are viewed as binary, so our serialized messages can be passed as
arguments for the functions mentioned above.
