require 'spec_helper'
require 'ostruct'

describe Branch do

  describe "self.sync" do
    it "finds or create builds by branch name and updates latest build number" do
      branch = stub_model(Branch)
      job = stub_model(Job)
      job.should_receive(:find_or_initialize_branch_by_name).with("origin/master").and_return(branch)
      branch.should_receive(:last_build_number=).with(171)
      Branch.sync(job, [OpenStruct.new(:name => "origin/master", :number => 171)])
    end
  end

  describe "self.build_ids_to_preserve" do
    before(:each) do
      Branch.stub!(:max_builds_per_branch => 2)
    end

    it "returns up to max build ids per branch, ordered by build number" do
      job = stub_model(Job)
      branch_1 = FactoryGirl.create(:branch, :job_id => job)
      branch_2 = FactoryGirl.create(:branch, :job_id => job)

      3.times do |i|
        number = i + 1
        branch_1.builds.create(:number => number)
        branch_2.builds.create(:number => number)
      end

      build_ids_to_preserve = Branch.build_ids_to_preserve

      builds_to_preserve = Build.where(:id => build_ids_to_preserve)
      builds_to_preserve.size.should == 4
      build_numbers = builds_to_preserve.map(&:number)
      build_numbers.should_not include(1)
      build_numbers.should include(2)
      build_numbers.should include(3)
    end
  end

  describe "success?" do
    let(:branch) { build(:branch) }

    it "is true if most recent build is a success" do
      branch.save!
      branch.builds.create(:number => 1, :result_message => Jenkins::FAILURE)
      branch.builds.create(:number => 2, :result_message => Jenkins::SUCCESS)
      branch.should be_success
    end

    it "is false if most recent build is not a success" do
      branch.builds.build(:number => 1, :result_message => Jenkins::FAILURE)
      branch.should_not be_success
    end

    it "is false if no builds" do
      branch.should_not be_success
    end
  end
end
