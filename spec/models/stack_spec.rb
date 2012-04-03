require 'spec_helper'

describe Stack do
  let(:stack) { build(:stack) }

  describe "result" do
    
    it "success, all jobs are success" do
      jobs = [
        stub_model(Job, :success? => true, :sha => '1234'),
        stub_model(Job, :success? => true, :sha => '1234')
      ]
      stack.stub!(:jobs).and_return(jobs)
      stack.success?.should be_true
      stack.result.should == :success
    end

    it "failure, any jobs are failing" do
      jobs = [
        stub_model(Job, :success? => true),
        stub_model(Job, :success? => false, :failure? => true)
      ]
      stack.stub!(:jobs).and_return(jobs)
      stack.failure?.should be_true
      stack.result.should == :failure
    end

    it "unknown, any job status is unknown" do
      jobs = [
        stub_model(Job, :success? => true,  :failure? => false, :unknown_status? => false),
        stub_model(Job, :success? => false, :failure? => false, :unknown_status? => true)
      ]
      stack.stub!(:jobs).and_return(jobs)
      stack.unknown_status?.should be_true
      stack.result.should == :unknown
    end

    it "unknown, any job shas are out of sync" do
      jobs = [
        stub_model(Job, :success? => true, :sha => '1234', :failure? => false, :unknown_status? => false),
        stub_model(Job, :success? => true, :sha => '5678', :failure? => false, :unknown_status? => true)
      ]
      stack.stub!(:jobs).and_return(jobs)
      stack.unknown_status?.should be_true
      stack.result.should == :unknown
    end


  end
end
