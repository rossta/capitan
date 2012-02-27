namespace :jenkins do

  desc "Sync jenkins job data"
  task :sync_jobs => :environment do
    BuildPoller.retrieve_and_sync_jobs
  end

  desc "Sync all built branch data"
  task :sync_branches => :environment do
    BuildPoller.retrieve_and_sync_branches
  end

  desc "Sync all builds for jobs by branch"
  task :sync_builds => :environment do
    BuildPoller.retrieve_and_sync_builds
  end

  desc "Sync current job, branch, and build data"
  task :sync => [:sync_jobs, :sync_branches, :sync_builds]
end