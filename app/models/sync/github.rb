module Sync
  class Github

    def self.api
      ::Github.api
    end

    def self.retrieve_and_sync_users
      User.sync('github', api.team_members)
    end

    def self.retrieve_and_sync_user_info
      User.provider('github').each do |user|
        user.sync(api.get(user.provider_url))
      end
    end


  end
end