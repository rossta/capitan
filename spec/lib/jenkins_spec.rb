require 'spec_helper'
require 'jenkins'

describe Jenkins do
  before(:each) do
    Jenkins.reset_configuration
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

  describe "finished?" do

    it "is false if result is nil" do
      Jenkins.finished_result?(nil)
    end

    it "is false if result is blank" do
      Jenkins.finished_result?("")
    end

    it "is false if message does not represent finished build" do
      Jenkins.finished_result?("BUIDLING").should be_false
    end

    it "is true if a finished result message jenkins (success, failure)" do
      Jenkins.finished_result?("SUCCESS").should be_true
      Jenkins.finished_result?("FAILURE").should be_true
      Jenkins.finished_result?("ABORTED").should be_true
    end
  end

end
