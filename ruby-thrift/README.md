# Description

Ruby application which uses `tackle` AMQP client for transporting `thrift` models to another application.

Thrift models are located inside `thrift` folder.

Assume model `User` in `thrift/models.thrift`:

```thrift
struct User {
  1: string name
  2: i32 age
}
```

`.thrift` file should be compiled with

``` bash
thrift -r --gen rb thrift/models.thrift
```

## Decoding

Received message from another application is decoded with:

```ruby
require "thrift_serializer"

user = ThriftSerializer.decode(message, User.new)
```

## Encoding

We can also encode model and send its encoded version via `tackle`:

```ruby
require "thrift_serializer"

user      = User.new
user.name = "John Smith"
user.age  = 42

binary = ThriftSerializer.encode(message)
```

Than we can send serialized message with `tackle`:

```ruby
Tackle.publish(binary, options)
```
