namespace :status do

  desc 'Print status of all existing builds'
  task :print => :environment do |t, args|
    puts CLI::BuildFormatter.new(Build.status.all)
  end

end

desc 'Print status of all existing builds'
task :status => ['status:print']