module Capitan
  class Environment
    extend Capitan::Redis

    def self.all_by_key(redis_key)
      redis.hgetall(redis_key)
    end

    def self.names_by_key(redis_key)
      redis.hvals(redis_key)
    end

    def self.name_for_key(redis_key, environment_key)
      redis.hget(redis_key, environment_key)
    end

    def self.add(redis_key, environment_key, environment_name)
      redis.hset(redis_key, environment_key, environment_name)
    end

    attr_accessor :app, :key

    # key: 'staging', 'production', etc.

    def initialize(attributes = {})
      attributes.each do |attribute, value|
        send("#{attribute}=", value)
      end
    end

    def last_deploy
      app.last_deploy(key)
    end

    def name
      self.class.name_for_key(app.redis_environments_key, key)
    end

    def name=(new_name)
      self.class.add(app.redis_environments_key, key, new_name)
    end

    def ==(environment)
      environment.app == self.app && environment.key == self.key && environment.name == self.name
    end

    def config
      {
        environment_name: name,
        app_name:         app.name,
        account:          app.account_name
      }
    end

  end
end