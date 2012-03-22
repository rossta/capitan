require 'spec_helper'

describe Github::Collection do
  
  let(:collection) { 
    Github::Collection.new do |coll|
      coll.member_class = Github::TeamMember
    end
  }

  before do
    @team_member_attributes = [
      {"id" => 2, "login" => "defunkt" },
      {"id" => 3, "login" => "mojombo" }
    ]
    collection.reset(@team_member_attributes)
  end

  it "should instantiate team members from given attributes" do
    collection.first.should be_a(Github::TeamMember)
    collection.size.should == 2
  end

  describe "find" do
    it "should be able to find an existing id with valid id" do
      collection.find(2).should == Github::TeamMember.new("id" => 2, "login" => "defunkt")
    end

    it "returns nil if no member with given id" do
      collection.find(1000).should be_nil
    end
  end

end