require 'spec_helper'
require 'jenkins'

describe Jenkins do
  before(:each) do
    Jenkins.reset_configuration
  end

  def load_jenkins_config_yml
    YAML.load_file(Rails.root.join("config", "jenkins.yml")).tap do |yaml|
      Jenkins.configure do |config|
        config.host      = yaml["host"]
        config.user_name = yaml["user_name"]
        config.token     = yaml["token"]
      end
    end
  end

  it "is configurable" do
    Jenkins.configure do |c|
      # :host, :user_name, :token
      c.host = 'http://ci.example.com'
      c.user_name = 'jenkins'
      c.token = 'abcd1234'
    end

    Jenkins.configuration.host = 'http://ci.example.com'
    Jenkins.configuration.user_name = 'jenkins'
    Jenkins.configuration.token = 'abcd1234'
  end

  describe "api", :vcr do
    before(:each) do
      load_jenkins_config_yml
    end

    it "display build attributes for job, build number" do
      build_object = Jenkins.api_job_build('models', 171)

      build_object.job_name.should == 'models'
      build_object.build_number.should == 171
      build_object.result.should == 'SUCCESS'
      build_object.timestamp.should == 1330028752673
      build_object.building.should be_false
      build_object.branch_name.should == 'origin/master'
    end
  
    it "displays all build numbers for branches" do
      branch_objects = Jenkins.api_branches('models')
      branch_objects.map(&:name).should include("origin/master")
      branch = branch_objects.detect { |branch| branch.name == "origin/master" }
      branch.number.to_s.should =~ /\d+/
    end
    
    it "displays all jobs" do
      job_objects = Jenkins.api_jobs
      job_objects.map(&:name).should include("models")
    end
  end

end
