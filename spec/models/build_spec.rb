require 'spec_helper'

describe Build do

  describe "self.sync" do
    let(:build_data) { OpenStruct.new.tap do |build|
                          build.job_name      = 'models'
                          build.build_number  = 171
                          build.result        = "SUCCESS"
                          build.timestamp     = 1234567890123
                          build.building      = false
                          build.branch_name   = 'origin/master'
                          build.branch_id     = 2
                        end
    }

    it "finds or creates build by job, number" do
      stub_build = stub_model(Build, :finished? => false)
      stub_branch = stub_model(Branch)
      stub_branch.should_receive(:find_or_initialize_build_by_number).with(171).and_return(stub_build)
      stub_build.should_receive(:save).and_return(true)
      Build.sync(stub_branch, build_data)
    end

    it "doesn't update result if previously known" do
      stub_build = stub_model(Build, :finished? => true)
      stub_branch = stub_model(Branch)
      stub_branch.should_receive(:find_or_initialize_build_by_number).with(171).and_return(stub_build)
      stub_build.should_not_receive(:result_message=)
      Build.sync(stub_branch, build_data)
    end

  end

  describe "self.trim_by_branch" do
    before(:each) do
      Branch.stub!(:build_ids_to_preserve => [2, 3])
    end

    it "destroys build ids not in list to preserve by branch" do
      Build.should_receive(:destroy_all).with(["id NOT IN (?)", [2, 3]])
      Build.trim_by_branch
    end
  end

  describe "result" do
    let(:build) { Build.new }

    it "from nil result message" do
      build.result_message = nil
      build.result.should be_blank
    end

    it "from SUCCESS result message" do
      build.result_message = "SUCCESS"
      build.result.should == :success
    end

    it "from FAILURE result message" do
      build.result_message = 'FAILURE'
      build.result.should == :failure
    end

    it "from ABORTED result message" do
      build.result_message = 'ABORTED'
      build.result.should == :aborted
    end

  end

  describe "finished?" do
    let(:build) { Build.new }

    it "is false for Jenkins unfinished/unknown result message" do
      build.result_message = ""
      Jenkins.should_receive(:finished_result?).with("").and_return(false)
      build.finished?.should be_false
    end

    it "is false for Jenkins unfinished/unknown result message" do
      build.result_message = "UNKNOWN"
      Jenkins.should_receive(:finished_result?).with("UNKNOWN").and_return(false)
      build.finished?.should be_false
    end

    it "is true for Jenkins finished result message" do
      build.result_message = "SUCCESS"
      Jenkins.should_receive(:finished_result?).with("SUCCESS").and_return(true)
      build.finished?.should be_true
    end
  end
end
