module App
  class RThrift
    require "thrift"
    $:.push("thrift/gen-rb")
    require "models_constants"

    @serializer   = Thrift::Serializer.new
    @deserializer = Thrift::Deserializer.new

    def self.serialize(message)
      @serializer.serialize(message)
    end

    def self.deserialize(message)
      @deserializer.deserialize(Message.new, message)
    end

  end
end
