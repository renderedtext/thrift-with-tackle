# Introduction

Simple demo of communication between ```elixir``` and ```ruby``` applications via ```thrift``` models using ```tackle``` AMQP client.

# Usage

## Ruby

Inside ```ruby-thrift``` directory <br>

Compile ```.thrift``` file with:

```bash
thrift -r --gen rb thrift/models.thrift
```

Start application with:
```bash
bundle exec ruby lib/app.rb
```

After starting, ruby app is subscribed to ```ruby-exchange```
