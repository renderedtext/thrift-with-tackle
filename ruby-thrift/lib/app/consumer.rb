module App
  class Consumer
    require "tackle"
    require_relative "rthrift"

    def self.subscribe(options)
      Tackle.subscribe(options) do |raw_message|
        message = RThrift.deserialize(raw_message)
        puts "#{message.url} - #{message.payload}"
      end
    end

  end
end
