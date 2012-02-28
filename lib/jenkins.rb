require 'faraday'
require 'faraday_middleware'
require 'ostruct'

module Jenkins
  extend self
  autoload :Configuration, 'jenkins/configuration'
  autoload :API, 'jenkins/api'

  delegate :configure, :to => :configuration

  RESULT_MESSAGES = {
    FAILURE = 'FAILURE' => :failure,
    SUCCESS = 'SUCCESS' => :success,
    ABORTED = 'ABORTED' => :aborted
  }

  def result_messages
    RESULT_MESSAGES
  end

  def result_for(result_message)
    RESULT_MESSAGES[result_message]
  end

  def configuration
    @_configuration ||= Configuration.new
  end

  def reset_configuration
    @_configuration = nil
    @_api = nil
  end

  def api
    @_api ||= API.new(configuration)
  end

  def get_jobs(attributes = {})
    api.jobs(attributes)
  end

  def get_branches(job_name, attributes = {})
    api.branches(job_name, attributes)
  end

  def get_build(job_name, build_number, attributes = {})
    api.build(job_name, build_number, attributes)
  end

end