namespace :sync do

  desc "Trim old builds by branch"
  task :trim_builds_by_branch => :environment do
    Build.trim_by_branch
  end

  desc "Trim ci data"
  task :trim => ["sync:trim_builds_by_branch"]

end

desc "Sync new and existing jobs and builds by branch, remove old ones"
task :sync => ['jenkins:sync', 'sync:trim']