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

end
