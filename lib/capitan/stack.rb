module Capitan
  class Stack < ActiveRecord::Base
    # t.string :title
    # t.string :application
    # t.string :environment
    # t.string :account

    has_many :apps

    def sync_last_deploy(environment_key)
      apps.map { |app| app.sync_last_deploy(environment_key) }
    end

  end
end

# class PlatformStaging < Base
#   environment 'challengepost_staging'
#   application 'challengepost'
#   account     'challengepostcom'
# end
#
# class PlatformProduction < Base
#   environment 'challengepost_production'
#   application 'challengepost'
#   account     'challengepostcom'
# end