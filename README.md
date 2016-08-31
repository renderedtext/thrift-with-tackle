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
