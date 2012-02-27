require 'spec_helper'

describe "Requests", :type => :request do
  include Rack::Test::Methods

  describe "home page" do
    before(:each) do
      Factory(:'capitan/stack', title: "Our Stack")
    end

    it "displays stacks" do
      visit "/"
      page.should have_content("Our Stack")
    end
  end
end