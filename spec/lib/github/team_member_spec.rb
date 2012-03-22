require 'spec_helper'

describe Github::TeamMember do
  
  describe "==" do
    it "is true based on identity" do
      Github::TeamMember.new("id" => 2).should == Github::TeamMember.new("id" => 2)
    end

    it "is false with mismatched ids" do
      Github::TeamMember.new("id" => 2).should_not == Github::TeamMember.new("id" => 3)
    end

    it "is false with mismatched classes" do
      Github::TeamMember.new("id" => 2).should_not == Github::Organization.new("id" => 2)
    end
  end
end