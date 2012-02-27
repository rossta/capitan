require 'spec_helper'

describe Job do
  
  describe "sync_jobs" do
    it "finds or creates jobs by name" do
      Job.should_receive(:find_or_create_by_name).with("models")
      Job.sync [OpenStruct.new(:name => "models")]
    end
  end
end
