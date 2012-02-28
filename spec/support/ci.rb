module CiHelper
  def load_jenkins_config_yml
    YAML.load_file(Rails.root.join("config", "jenkins.yml")).tap do |yaml|
      Jenkins.configure do |config|
        config.host      = yaml["host"]
        config.user_name = yaml["user_name"]
        config.token     = yaml["token"]
      end
    end
  end
  
end

RSpec.configuration.send(:include, CiHelper)