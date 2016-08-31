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

## Deserialization

Received message from another application is deserialized with:

```ruby
deserializer = Thrift::Deserializer.new
user = deserializer.deserialize(User.new, message)
```

## Serialization

We can also serialize model and send its serialized version via `tackle`:

```ruby
user      = User.new
user.name = "John Smith"
user.age  = 42

serializer = Thrift::Serializer.new
binary = serializer.serialize(message)
```

Than we can send serialized message with `tackle`:
```ruby
Tackle.publish(binary, options)
```
