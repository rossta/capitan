require 'faraday'
require 'faraday_middleware'
require 'ostruct'

module Jenkins
  extend self
  autoload :Configuration, 'jenkins/configuration'

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
  end

  def api_jobs
    jobs_json = get
    [].tap do |jobs|
      jobs_json["jobs"].each do |job_hash|
        jobs << OpenStruct.new(:name => job_hash["name"])
      end
    end
  end

  def api_branches(job_name)
    all_builds_json = get "/job/#{job_name}/lastBuild"

    [].tap do |branches|
      all_builds_json["actions"][1]["buildsByBranchName"].each do |branch_name, build_hash|
        branches << OpenStruct.new(:name => branch_name, :number => build_hash["buildNumber"])
      end
    end
  end

  def api_job_build(job_name, build_number)
    build_json = get "/job/#{job_name}/#{build_number}"

    branch_name = branch_name_from_build_json(build_json, build_number)

    OpenStruct.new.tap do |build|
      build.job_name      = 'models'
      build.build_number  = build_number.to_i
      build.result        = build_json["result"]
      build.timestamp     = build_json["timestamp"]
      build.building      = build_json["building"]
      build.branch_name   = branch_name
    end
  end

  def connection
    @connection = Faraday.new(url: Jenkins.configuration.host, port: 8080) do |conn|
      conn.request :basic_auth, Jenkins.configuration.user_name, Jenkins.configuration.token
      conn.request :json

      conn.response :json, :content_type => /\bjson|javascript$/
      conn.response :logger

      conn.use :instrumentation
      conn.adapter Faraday.default_adapter
    end
  end

  def get(path = nil)
    connection.get("#{path}/api/json").body
  end

  def root
    get ''
  end

  def get_job(name)
    get "/job/#{name}"
  end

  def get_job_build(name, number)
    get "/job/#{name}/#{number}"
  end

  def get_latest_build(name)
    get "/job/#{name}/lastBuild"
  end

  private

  def branch_name_from_build_json(build_json, build_number)
    actions_json = build_json["actions"] || []
    return nil unless actions_json.any?
    actions_metadata_json = actions_json[1]
    return nil unless actions_metadata_json.any?
    branch_json = actions_metadata_json["buildsByBranchName"]
    return nil unless branch_json.any?

    branch_json.select {|k,hash|
      hash["buildNumber"] == build_number && k !~ /HEAD/
    }.keys.first
  end

end