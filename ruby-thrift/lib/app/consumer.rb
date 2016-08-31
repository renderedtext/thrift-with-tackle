module App
  class Consumer
    require "tackle"
    require_relative "rthrift"

    def self.subscribe(options)
      Tackle.subscribe(options) do |raw_message|
        message = RThrift.deserialize(raw_message)
        puts "URL: #{message.url}\nPaylod: #{message.payload}"
      end
    end

  end
end
