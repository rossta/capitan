require 'engineyard'
require 'engineyard/cli'

module Capitan
  module Engineyard
    extend self

    def api
      @api ||= ::EY::CLI::API.new
    end

    def repo
      @repo ||= ::EY::Repo.new
    end

    def last_deployment(config)
      ey_app, environment = ey_app_and_environment(config)
      ey_app.last_deployment_on(environment)
    end

    # --environment='challengepost_production' --app='challengepost' --account='challengepostcom'

    def ey_app_and_environment(config)
      # {
      #   app_name:         config.app_name,
      #   environment_name: config.environment_name,
      #   account:          config.account_name
      # }
      api.resolver.app_and_environment(config)
    end

    def last_deployment_on_stack(stack)
      app, environment = stack_app_and_environment(stack)
      app.last_deployment_on(environment)
    end

    def stack_app_and_environment(stack)
      api.resolver.app_and_environment({
        environment_name: stack.environment,
        app_name: stack.application,
        account: stack.account
      })
    end

  end
end
