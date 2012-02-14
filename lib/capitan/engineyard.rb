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
      #   app_name:         "app name",
      #   environment_name: "app_environment",
      #   account_name:     "account name"
      # }
      api.resolver.app_and_environment(HashWithIndifferentAccess.new(config))
    end

    def last_deployment_on_stack(stack)
      app, environment = stack_app_and_environment(stack)
      app.last_deployment_on(environment)
    end

    def stack_app_and_environment(stack)
      api.resolver.app_and_environment({
        environment: stack.environment,
        app: stack.application,
        account: stack.account
      })
    end

  end
end
