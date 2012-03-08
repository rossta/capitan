require 'spec_helper'

describe Sync::Jenkins, :vcr, :record => :new_episodes do

  before { Jenkins.configure_for_environment }

  it "retrieves and syncs jobs, branches and builds for enabled jobs" do
    Sync::Jenkins.retrieve_and_sync_jobs
    Sync::Jenkins.retrieve_and_sync_branches
    Sync::Jenkins.retrieve_and_sync_builds
  end
end
