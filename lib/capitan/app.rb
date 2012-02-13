module Capitan
  class App < ActiveRecord::Base
    include Capitan::Redis
    
    has_many :deploys, order: 'finished_at DESC'

    def last_ey_deploy(environment_key)
      Engineyard.last_deployment(ey_config(environment_key))
    end

    def sync_last_deploy(environment_key)
      ey_deploy = last_ey_deploy(environment_key)
      deploys.find_or_initialize_by_provider_id(ey_deploy.id).tap do |deploy|
        deploy.sync_with_ey_deploy(ey_deploy)
      end
    end

    def ey_config(environment_key)
      {
        app_name:         name,
        environment_name: environments[environment_key],
        account:          account_name
      }
    end

    def environments
      @environments ||= Environment.all_by_key(redis_environments_key).map do |key, name|
        Environment.new(app: self, key: key, name: name)
      end
    end
    
    def environment_names
      @environment_names ||= Environment.names_by_key(redis_environments_key)
    end
    
    def add_environment(environment_key, environment_name)
      Environment.add(redis_environments_key, environment_key, environment_name)
    end

    def redis_environments_key
      "#{base_redis_key}:environments"
    end

    def base_redis_key
      "#{self.class.name}:#{id}"
    end

  end
end