require 'spec_helper'

describe Capitan do

  describe "version" do
    it "should be set" do
      Capitan::VERSION.should == "0.0.1"
    end
  end
end
