module App
  class Publisher
    require "tackle"

    def self.publish(message, options)
      Tackle.publish(message, options)
    end
    
  end
end
