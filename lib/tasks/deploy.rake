module AppCloud
  def self.deploy(cloud_env, with_migrations = false)
    case cloud_env.to_sym
    when :weplay_staging
      branch_name = ENV['BRANCH'] || 'staging'
    when :weplay_production
      branch_name = 'production'
    else
      raise "Unknown CLOUD_ENV #{cloud_env}"
    end

    args = ["-e #{cloud_env}"]
    args << "-r #{branch_name}"
    args << "--no-migrate" unless with_migrations
    args << "--verbose"

    cmd = "./bin/ey deploy #{args.join(' ')}"
    puts cmd
    system(cmd)
  end
end

task :deploy => "deploy:staging"

namespace :deploy do

  desc "Tag and deploy staging to AppCloud (supply BRANCH=topic to skip tagging and deploy that branch)"
  task :staging do
    unless ENV['BRANCH']
      Rake::Task["tag:staging"].invoke
    end
    AppCloud::deploy(:weplay_staging, false)
  end

  namespace :staging do
    desc "Tag deploy staging with migrations to AppCloud with migrations (supply BRANCH=topic to skip tagging and deploy that branch)"
    task :migrations do
      unless ENV['BRANCH']
        Rake::Task["tag:staging"].invoke
      end
      AppCloud::deploy(:weplay_staging, true)
    end
  end

  desc "Deploy production to EngineYard AppCloud without migrations. Accepts SHA or BRANCH, or defaults to staging."
  task :production do
    ENV['MIGRATIONS'] = 'false'
    Rake::Task["deploy:production:default"].invoke
  end

  namespace :production do
    desc "Prompt and deploy production to EngineYard AppCloud. Accepts SHA or BRANCH, or defaults to staging."
    task :default do

      if ENV['SHA']
        ENV['DIFF_SHA'] = ENV['SHA']
      else
        ENV['DIFF_BRANCH'] = ENV['BRANCH'] || 'staging'
      end
      Rake::Task['diff'].invoke
      puts "\nDo you want to tag and deploy this diff from #{ENV['DIFF_SHA'] || ENV['DIFF_BRANCH']} to production? [Yes/No]"
      response = STDIN.gets.chomp
      if response.downcase == "yes"
        puts "Tagging production..."
        ENV['NO_DIFF'] ||= 'true'
        Rake::Task["tag:production"].invoke
        puts "Deploying production..."
        AppCloud::deploy(:weplay_production, ENV['MIGRATIONS'] == 'true')
      else
        puts "\nDeploy current production tag to production? [Yes/No]"
        response = STDIN.gets.chomp
        if response.downcase == "yes"
          puts "Deploying production..."
          AppCloud::deploy(:weplay_production, ENV['MIGRATIONS'] == 'true')
        end
      end
    end

    desc "Run migrations while deploying production to EngineYard AppCloud with migrations. Accepts SHA or BRANCH, or defaults to staging."
    task :migrations do
      ENV['MIGRATIONS'] = 'true'
      Rake::Task["deploy:production:default"].invoke
    end
  end
end