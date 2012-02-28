require 'spec_helper'

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
      branch_1 = Factory(:branch, :job_id => job)
      branch_2 = Factory(:branch, :job_id => job)

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

  describe "last_build_number" do
    let(:branch) { Branch.new(:name => 'origin/master', :job_id => 1) }

    it "returns last build number in array of build numbers" do
      branch.build_numbers = [1, 2]
      branch.last_build_number.should == 2
    end

    it "sets last build number, adds to array of build numbers" do
      branch.build_numbers = [1, 2]
      branch.last_build_number = 3
      branch.last_build_number.should == 3
      branch.build_numbers.should == [1, 2, 3]
    end

    it "saves build_numbers" do
      branch.build_numbers = [1, 2]
      branch.save

      Branch.last.build_numbers.should == [1, 2]
    end

    it "does not add duplicates" do
      branch.build_numbers = [1, 2]
      branch.last_build_number = 2
      branch.build_numbers.should == [1, 2]
    end
  end
end
