require 'jenkins'

YAML.load_file("config/jenkins.yml").tap do |yaml|
  Jenkins.configure do |config|
    config.host      = yaml["host"]
    config.user_name = yaml["user_name"]
    config.token     = yaml["token"]
  end
end