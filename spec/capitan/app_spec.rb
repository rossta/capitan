require 'spec_helper'

describe Capitan::App do
  describe "environments" do
    let(:app) { Factory.create(:'capitan/app') }

    it "returns Environment instance for each environment key" do
      app.add_environment('staging', 'staging_app')
      environment = app.environments.last
      environment.key.should == 'staging'
    end
  end
end
