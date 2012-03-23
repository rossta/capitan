class Notification

  # Public: Create a new notification with params (likely via controller).
  #
  # hash  - params from controller
  #         { "name" => "JobName", 
  #           "url" => "JobUrl", 
  #           "build" => {
  #             "number" => 1, 
  #             "phase" => "STARTED", 
  #             "status" => "FAILED", 
  #             "url" => "job/project/5", 
  #             "fullUrl" => "http://ci.jenkins.org/job/project/5"
  #             "parameters" => {
  #               "branch" => "master"
  #             }
  #         }} 
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
    name = @params[:name]
    Sync::Jenkins.job_by_name(name)
  end
end