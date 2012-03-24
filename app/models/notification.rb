require 'json'

class Notification

  # Public: Create a new notification with params (likely via controller).
  #
  # hash  - params from controller
  #         {"{\"name\":\"topic_action\",\"url\":\"job/topic_action/\",\"build\":{\"full_url\":\"http://ci.berman.challengepost.com/job/topic_action/364/\",\"number\":364,\"phase\":\"FINISHED\",\"status\":\"SUCCESS\",\"url\":\"job/topic_action/364/\"}}"=>nil, "controller"=>"notifications", "action"=>"create", "id"=>"jenkins"} 
  #
  # Examples
  #
  #   multiplex('Tom', 4)
  #   # => 'TomTomTomTom'
  #
  # Returns the duplicated String.
  def initialize(params)
    @params = params
  end

  # Public: executes notification based on params passed on
  # initialize.
  # Currently only supports jenkins noifications
  #
  # Examples
  #
  #   notification = Notification.new(jenkins_notification_params)
  #   notification.process!
  #   # => nil
  #
  # Returns nil
  def process!
    Sync::Jenkins.job_by_name(payload["name"])
  end

  # Public: Parses the given param data as json
  #
  # Examples
  #
  #   notification.payload
  #   # => { 
  #           "name": "topic_action",
  #           "url": "job/topic_action/", 
  #           "build": { 
  #             "full_url": "http://ci.berman.challengepost.com/job/topic_action/364/",
  #             "number": 364,
  #             "phase": "STARTED",
  #             "url": "job/topic_action/364/"
  #           }
  #         }
  #
  # Returns hash of notification payload.
  def payload
    @payload ||= JSON.parse(@params.keys.grep(/job/).first)
  end

  private

  # Rails intreprets Jenkins payload as a string params key with
  # a nil value. Choose key by matching /job/ and parse as json 
  def parsed_params
    
  end

end