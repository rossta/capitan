require 'yaml'
env = ENV['RACK_ENV'] || "development"
databases = YAML.load_file("config/database.yml")
ActiveRecord::Base.establish_connection(databases[env])

YAML.load_file("config/jenkins.yml").tap do |yaml|
  Capitan::Jenkins::Config.configure do |config|
    config.host      = yaml["host"]
    config.user_name = yaml["user_name"]
    config.token     = yaml["token"]
  end
end