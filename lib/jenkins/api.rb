module Jenkins

  class API
    def initialize(configuration)
      @configuration = configuration
    end

    def jobs(attributes = {})
      jobs_json = get
      [].tap do |jobs|
        jobs_json["jobs"].each do |job_hash|
          jobs << OpenStruct.new(attributes.merge(:name => job_hash["name"]))
        end
      end
    end

    def branches(job_name, attributes = {})
      all_builds_json = get "/job/#{job_name}/lastBuild"

      [].tap do |branches|
        all_builds_json["actions"][1]["buildsByBranchName"].each do |branch_name, build_hash|
          branches << OpenStruct.new(attributes.merge(:name => branch_name, :number => build_hash["buildNumber"]))
        end
      end
    end

    def build(job_name, build_number, attributes = {})
      build_json = get "/job/#{job_name}/#{build_number}"

      branch_name = branch_name_from_build_json(build_json, build_number)

      OpenStruct.new(attributes).tap do |build|
        build.job_name      = 'models'
        build.build_number  = build_number.to_i
        build.result        = build_json["result"]
        build.timestamp     = build_json["timestamp"]
        build.building      = build_json["building"]
        build.branch_name   = branch_name
      end
    end

    protected

    def get(path = nil)
      connection.get("#{path}/api/json").body
    end

    def connection
      @connection = Faraday.new(url: @configuration.host, port: 8080) do |conn|
        conn.request :basic_auth, @configuration.user_name, @configuration.token
        conn.request :json

        conn.response :json, :content_type => /\bjson|javascript$/
        conn.response :logger unless Rails.env.test?

        conn.use :instrumentation
        conn.adapter Faraday.default_adapter
      end
    end

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
end