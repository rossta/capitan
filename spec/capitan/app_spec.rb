require 'spec_helper'

describe Capitan::App do

  describe "instance methods" do
    let(:app) { Factory.create(:'capitan/app', name: 'CP App', account_name: 'CP Account') }

    describe "ey_config" do
      it "returns hash for ey api" do
        environment = stub(Capitan::Environment, key: 'staging', name: 'cp_staging')
        environments = [environment]
        environment.should_receive(:config).and_return(:config)
        app.stub!(:environments).and_return(environments)
        app.ey_config('staging').should == :config
      end
    end

    describe "environments" do
      let(:app) { Factory.create(:'capitan/app') }

      it "returns Environment instance for each environment key" do
        app.add_environment('staging', 'staging_app')
        environment = app.environments.last
        environment.key.should == 'staging'
      end
    end
    
    describe "display_name" do
      it "titleizes" do
        
      end
    end
  end
end
