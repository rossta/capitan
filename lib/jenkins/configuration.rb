require 'active_support/configurable'

module Jenkins
  class Configuration
    include ActiveSupport::Configurable
    config_accessor :host, :user_name, :token

    def configure
      yield self
      self
    end
  end
end