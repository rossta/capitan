require 'spec_helper'

describe Build do

  describe "sync" do
    it "finds or creates build by job, number" do
      build_data = OpenStruct.new.tap do |build|
        build.job_name      = 'models'
        build.build_number  = 171
        build.result        = "SUCCESS"
        build.timestamp     = 1234567890123
        build.building      = false
        build.branch_name   = 'origin/master'
      end

      stub_build = stub_model(Build)
      stub_job = stub_model(Job)
      stub_job.should_receive(:find_or_initialize_build_by_number).with(171).and_return(stub_build)
      stub_build.should_receive(:save).and_return(true)
      Build.sync(stub_job, :data => build_data, :branch_id => 2)
    end
  end

  describe "result" do
    let(:build) { Build.new }

    it "from nil result message" do
      build.result_message = nil
      build.result.should == :unknown
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
end
