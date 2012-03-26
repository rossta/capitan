require 'gardenwall'

module Sync
  class Github

    def self.api
      GardenWall::Github.api
    end

    def self.retrieve_and_sync_users
      Authentication.sync('github', GardenWall.organization.team_member_attributes)
    end

    def self.retrieve_and_sync_user_info
      Authentication.provider('github').each do |user|
        user.sync(api.get(user.provider_url))
      end
    end


  end
end