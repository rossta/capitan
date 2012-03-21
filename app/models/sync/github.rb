module Sync
  class Github

    def self.api
      ::Github.api
    end

    def self.retrieve_and_sync_users
      Authentication.sync('github', api.team_members)
    end

    def self.retrieve_and_sync_user_info
      Authentication.provider('github').each do |user|
        user.sync(api.get(user.provider_url))
      end
    end


  end
end