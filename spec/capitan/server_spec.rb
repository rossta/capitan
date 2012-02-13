require 'spec_helper'

describe Capitan::Server do
  include Rack::Test::Methods

  describe "/" do
    it "should respond to /" do
      get '/'
      last_response.should be_ok

      response_body do |body|
        body.should include('Welcome to')
        body.should include('Capitan')
        body.should include('Stacks')
      end
    end
  end
end
