require 'spec_helper'

describe Sync::Github, :vcr, :record => :all do

  it "retrieves and syncs user" do
    Sync::Github.retrieve_and_sync_users
    Sync::Github.retrieve_and_sync_user_info
  end
end
