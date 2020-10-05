module ModelCache
  module Engine
    @redis_handler = nil
    @initialized = false

    def self.init(redis_handler: nil)
      @redis_handler = redis_handler
      @initialized = true
    end

    def self.handler
      @redis_handler
    end
  end
end
