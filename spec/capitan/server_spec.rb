require 'spec_helper'

describe Capitan::Server do
  include Rack::Test::Methods

  describe "GET /" do
    it "responds to /" do
      get '/'
      last_response.should be_ok

      response_body do |body|
        body.should include('Welcome to')
        body.should include('Capitan')
        body.should include('Stacks')
      end
    end
  end
  
  describe "POST /builds" do
    
  end
end
