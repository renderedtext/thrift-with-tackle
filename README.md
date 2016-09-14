# Introduction

Simple demo of communication between `elixir` and `ruby` applications via `thrift` models using `tackle` AMQP client.

# Usage

## Ruby

Inside `ruby-thrift` directory <br>

Compile `.thrift` file with:

```bash
thrift -r --gen rb thrift/models.thrift
```

Start consuming messages from `elixir` app with:
```bash
bundle exec ruby lib/consume.rb
```

Send message to `elixir` app with:

```bash
bundle exec ruby lib/send.rb
```

## Elixir
Inside the `elixir-thrift` directory:<br/>
Run these commands like in any other elixir app:
```
mix deps.get
mix deps.compile
mix run --no-halt
```
This will enable you to receive messages.<br/>
For the sending, you'll need to add the following line to the code:
```elixir
ElixirThrift.Sender.send
```
This can be added in the `lib/elixir_thrift.ex` file. That means that only one
message will be sent, when the app is started. You can also add the line inside
the `handle_message` function in the `lib/elixir-thrift/receiver.ex` file. That
way, every time a message is received, a message will be sent to the ruby app.  
