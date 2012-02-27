namespace :status do

  desc 'Print status of all existing builds'
  task :print => :environment do
    Build.display_results
  end

end

desc 'Print status of all existing builds'
task :status => ['status:print']