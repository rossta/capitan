require 'rubygems'
require 'active_record'
require 'yaml'
require 'logger'

task :environment do
  $LOAD_PATH.unshift 'lib'
  require 'capitan'
end

namespace :db do
  desc "Load database environment"
  task :environment do
    $LOAD_PATH.unshift 'lib'
    require 'capitan'

    # env = ENV['RACK_ENV'] || "development"
    # databases = YAML.load_file("config/database.yml")
    # ActiveRecord::Base.establish_connection(databases[env])
  end

  desc "Migrate the database"
  task :migrate => :environment do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate("db/migrate")
  end

  desc "Load seed data"
  task :seed => :environment do
    eval(IO.read("db/seeds.rb"), binding)
  end

end