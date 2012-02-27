module Capitan
  module CI
    module Jenkins
      autoload :Config, 'capitan/ci/jenkins/config'
      autoload :API,    'capitan/ci/jenkins/api'

      def configure(*args)
        config.configure.send(*args)
      end

      def config
        @config ||= Config.new
      end
    end
  end
end