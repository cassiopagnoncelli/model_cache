require 'active_support/all'

require 'model_cache/version'
require 'model_cache/engine'

# Usage
#
# class RandomModel < ApplicationRecord
#   include ModelCache
#   model_cache_key :email
# end
#
# RandomModel.fetch('john@foo.com') == RandomModel.find('john@foo.com') # => true
# RandomModel.fetch('john@foo.com') == RandomModel.find('john@foo.com') # => true
#
module ModelCache
  extend ActiveSupport::Concern

  included do
    cattr_accessor :redis_cache_key

    before_update :del_old_cache, on: [:update]
    after_commit :set_cache, on: %i[create update]
    after_commit :del_cache, on: [:destroy]

    def set_cache
      ModelCache::Engine.handler.with { |conn| conn.hset(self.class.to_s, self.cache_key_id.to_s, self.to_json) } if ModelCache::Engine.handler.present?
    end

    def del_cache
      ModelCache::Engine.handler.with { |conn| conn.hdel(self.class.to_s, self.cache_key_id.to_s) } if ModelCache::Engine.handler.present?
    end

    def del_old_cache
      ModelCache::Engine.handler.with { |conn| conn.hdel(self.class.to_s, self.send("#{self.class.redis_cache_key}_was")) } if ModelCache::Engine.handler.present?
    end

    def cache_key_id
      send(self.class.redis_cache_key)
    end

    # Set model key to its primary key
    model_cache_key

    class << self
      def fetch(id)
        begin
          el = ModelCache::Engine.handler.present? ? ModelCache::Engine.handler.with(timeout: 0.5) { |conn| conn.hget(self.to_s, id.to_s) } : nil

          if el
            self.new(JSON.parse(el).symbolize_keys)
          else
            o = self.send(:find_by, { "#{self.redis_cache_key}": id })
            o.set_cache if o
            o
          end
        rescue Redis::CannotConnectError
          self.send(:find_by, { "#{self.redis_cache_key}": id })
        end
      end
    end
  end

  module ClassMethods
    def model_cache_key(field = self.primary_key)
      self.redis_cache_key = field.to_s
    end
  end
end
