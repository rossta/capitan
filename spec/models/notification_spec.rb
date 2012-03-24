require 'spec_helper'

describe Notification do
  let(:notification) { Notification.new(@params) }

  subject { notification }

  before do
    @params = {
      "{\"name\":\"topic_action\",\"url\":\"job/topic_action/\",\"build\":{\"full_url\":\"http://ci.berman.challengepost.com/job/topic_action/364/\",\"number\":364,\"phase\":\"STARTED\",\"url\":\"job/topic_action/364/\"}}"=>nil, 
      "controller" => "notifications", 
      "action" => "create", 
      "id" => "jenkins"
    }
  end

  it { subject.payload["name"].should == "topic_action" }
  it { subject.payload["url"].should == "job/topic_action/" }
  it { subject.payload["build"].should be_a(Hash) }
  it { subject.payload["build"]["full_url"].should == "http://ci.berman.challengepost.com/job/topic_action/364/" }
  it { subject.payload["build"]["number"].should == 364 }
  it { subject.payload["build"]["phase"].should == "STARTED" }
  it { subject.payload["build"]["url"].should == "job/topic_action/364/" }

  it "should process job sync" do
    Sync::Jenkins.should_receive(:job_by_name).with("topic_action")
    subject.process!
  end
end