require 'spec_helper'

describe Capitan::Environment do

  let(:app)         { Factory.build(:"capitan/app") }
  let(:deploy)      { Factory.build(:"capitan/deploy") }
  let(:environment) { Capitan::Environment.new(app: app, key: 'staging', name: 'challengepost_staging') }

  describe "self.add" do
    it "adds environment key and name redis hash by redis key" do
      redis_key = 'test_redis_key'
      Capitan::Environment.add(redis_key, 'staging', 'staging_name')
      environments = Capitan::Environment.all_by_key(redis_key)
      environments['staging'].should == 'staging_name'
    end
  end

  describe "last_deploy" do
    it "returns app's last deploy" do
      app.should_receive(:last_deploy).and_return(deploy)
      environment.last_deploy.should == deploy
    end
  end

  describe "key" do
    it "return key as symbol" do
      environment.key.should == 'staging'
    end
  end

  describe "name" do
    before(:each) do
      app.add_environment('staging', 'challengepost_staging')
    end

    it "returns environment name for app, key" do
      environment.name.should == 'challengepost_staging'
    end

    it "persists environment name across instances" do
      new_environment = Capitan::Environment.new(app: app, key: 'staging')
      new_environment.should == environment
      new_environment.name.should == 'challengepost_staging'
    end

    it "persists environment name across instances" do
      environment.name = 'challengepost_staging_2'
      new_environment = Capitan::Environment.new(app: app, key: 'staging')
      new_environment.name.should == 'challengepost_staging_2'
    end
  end

  describe "config" do
    it "should return hash for app attributes and name" do
      expected_config = {
        app_name:         app.name,
        environment_name: 'challengepost_staging',
        account:          app.account_name
      }
      environment.config.should == expected_config
    end
  end
end
