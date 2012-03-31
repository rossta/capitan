class GitCommands
  def self.verify_working_directory_clean
    return if `git status` =~ /working directory clean/
    raise "Must have clean working directory"
  end
  
  def self.ref(sha, branch)
    sha || branch
  end
  
  def self.remote_ref(sha, branch)
    sha ? sha : "origin/#{branch}"
  end
end


namespace :tag do
  desc "Update the staging branch to prepare for a deploy. Specify a BRANCH, SHA, or defaults to master."
  task :staging do
    GitCommands.verify_working_directory_clean

    `git fetch`
    `git branch -f staging origin/staging`
    `git checkout staging`

    `git reset --hard #{GitCommands.remote_ref(ENV['SHA'], ENV['BRANCH'] || 'master')}`
    
    `git push -f origin staging`
    `git checkout master`
    `git branch -D staging`
  end

  desc "Update the production branch to prepare for a release. Specify a SHA, or defaults to staging branch."
  task :production do
    Rake::Task["diff:staging"].invoke unless ENV['NO_DIFF']
    
    GitCommands.verify_working_directory_clean

    `git fetch`
    `git branch -f production origin/production`
    `git checkout production`
    
    `git reset --hard #{GitCommands.remote_ref(ENV['SHA'], ENV['BRANCH'] || 'staging')}`
    
    `git push -f origin production`
    `git checkout master`
    `git branch -D production`
  end

  task :clean_old do
    `git fetch`
    tags = `git tag -l`.split("\n")
    ['staging', 'production'].each do |enviro|
      enviro_tags = tags.grep(/^deployed_to_#{enviro}/)
      all_but_last_5 = enviro_tags.sort[0..-6]
      all_but_last_5.each do |tag|
        delete_cmd = "git tag -d #{tag}"
        puts delete_cmd
        puts `#{delete_cmd}`
        push_deletion_cmd = "git push origin :refs/tags/#{tag}"
        puts push_deletion_cmd
        puts `#{push_deletion_cmd}`
      end
    end
  end
end

desc "Show the differences between an arbitrary commit point and the production branch"
task :diff do
  raise "Must specify DIFF_BRANCH or DIFF_SHA to perform diff" unless GitCommands.ref(ENV['DIFF_SHA'], ENV['DIFF_BRANCH'])

  `git fetch`
  begin
    require "launchy"
    Launchy.open("https://github.com/weplay/weplay/compare/production...#{GitCommands.ref(ENV['DIFF_SHA'], ENV['DIFF_BRANCH'])}")
  rescue Exception
    puts `git diff origin/production #{GitCommands.remote_ref(ENV['DIFF_SHA'], ENV['DIFF_BRANCH'])}`
    puts "\n\nNB: Install launchy and you'll see a much nicer diff in a browser (gem install launchy)\n"
  end
end

namespace :diff do
  desc "Show the differences between the staging branch and the production branch"
  task :staging do
    ENV['DIFF_BRANCH'] = 'staging'
    Rake::Task['diff'].invoke
  end
end

namespace :branch do
  desc "Branch from production for a bug fix. Specify BRANCH=name"
  task :production do
    branch_name = ENV['BRANCH'] || "production_release"
    GitCommands.verify_working_directory_clean

    `git fetch`
    `git branch -f production origin/production`
    `git checkout production`
    `git branch #{branch_name}`
    `git checkout #{branch_name}`
    `git push origin #{branch_name}`
  end
end