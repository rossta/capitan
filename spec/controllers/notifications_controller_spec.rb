require 'spec_helper'

describe NotificationsController do

  NOTIFICATION_JSON = <<-JSON
                    {"name":"JobName",
                     "url":"JobUrl",
                     "build":{"number":1,
                        "phase":"STARTED",
                        "status":"FAILED",
                              "url":"job/project/5",
                              "fullUrl":"http://ci.jenkins.org/job/project/5",
                              "parameters":{"branch":"master"}
                       }
                    }
                  JSON

  before do
    @params = JSON.parse(NOTIFICATION_JSON)
  end

  describe "create" do
    let(:notification) { mock(Notification, :process! => nil) }

    before do
      Notification.stub!(:new => notification)
    end

    it "returns successfully" do
      post :create, @params
      response.should be_success
    end

    it "kicks off a sync of the given job" do
      Notification.should_receive(:new).and_return(notification)
      notification.should_receive(:process!)
      post :create, @params
    end
  end
end