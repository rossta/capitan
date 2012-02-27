require 'active_support/configurable'

module Capitan
  module Jenkins
    module Config
      include ActiveSupport::Configurable
      config_accessor :host, :user_name, :token

      def configure
        yield self
      end
    end
  end
end