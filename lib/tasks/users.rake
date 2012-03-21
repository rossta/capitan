namespace :authentications do

  desc "Sync jenkins job data"
  task :sync_github => :environment do
    Sync::Github.retrieve_and_sync_users
    Sync::Github.retrieve_and_sync_user_info
  end

  desc "Sync current job, branch, and build data"
  task :sync => [:sync_github]
end