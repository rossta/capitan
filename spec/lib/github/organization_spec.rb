require 'spec_helper'

describe Github::Organization, :vcr, :record => :new_episodes  do
  
  let(:organization) { Github::Organization.new(:name => 'challengepost') }

  it "should initialize with organization name" do
    organization.name.should == 'challengepost'  
  end

  it "should return team_members" do
    organization.team_members.should be_a(Github::Collection)
    organization.team_members.first.should be_a(Github::TeamMember)
  end

  describe "team_member?" do
    it "is true if has team member with given team member id" do
      team_member = organization.team_members.first
      organization.team_member?(team_member.id).should be_true
    end

    it "is true if has team member with given team member id" do
      organization.team_member?(-1).should be_false
    end
  end

end