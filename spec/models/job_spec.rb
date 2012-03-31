require 'spec_helper'
require 'ostruct'

describe Job do

  describe "sync_jobs" do
    it "finds or creates jobs by name" do
      Job.should_receive(:find_or_create_by_name).with("models")
      Job.sync [OpenStruct.new(:name => "models")]
    end
  end

  describe "self.build_ids_to_preserve" do
    before(:each) do
      Job.stub!(:max_branches_per_job => 2)
    end

    it "returns up to max build ids per branch, ordered by build number" do
      job_1 = FactoryGirl.create(:job)
      job_2 = FactoryGirl.create(:job)

      3.times do |i|
        number = i + 1
        job_1.branches.create(:name => 'origin/branch1', :last_build_number => number)
        job_2.branches.create(:name => 'origin/branch2', :last_build_number => number)
      end

      branch_ids_to_preserve = Job.branch_ids_to_preserve

      branch_ids_to_preserve = Branch.where(:id => branch_ids_to_preserve)
      branch_ids_to_preserve.size.should == 4
      branch_numbers = branch_ids_to_preserve.map(&:last_build_number)
      branch_numbers.should_not include(1)
      branch_numbers.should include(2)
      branch_numbers.should include(3)
    end
  end

  describe "instance methods" do
    let(:job) { Job.new }

    describe "disable!" do
      it "should set enabled to false" do
        job.should_receive(:update_attributes).with(enabled: false)
        job.disable!
      end
    end

    describe "disable!" do
      it "should set enabled to false" do
        job.should_receive(:update_attributes).with(enabled: false)
        job.disable!
      end
    end

    describe "success?" do
      let(:job) { build(:job) }
      let(:branch) { stub_model(Branch, :success? => false) }

      it "is true if most recent build on origin/master is passing" do
        job.master_branch = branch
        branch.stub!(:success? => true)
        job.should be_success
      end

      it "is false if most recent build on origin/master is failing" do
        branch.stub!(:success? => false)
        job.should_not be_success
      end
    end
  end

end
