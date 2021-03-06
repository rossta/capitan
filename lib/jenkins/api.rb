require 'faraday_middleware'
require 'ostruct'
require 'uri'

module Jenkins

  class API
    BRANCHES_TO_EXCLUDE = %w[origin/HEAD]

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
      return OpenStruct.new unless all_builds_json.present?

      branches_json   = all_builds_json["actions"][1]["buildsByBranchName"] || []

      [].tap do |branches|
        branches_json.each do |branch_name, build_hash|
          next if exclude_branch?(branch_name)
          branches << OpenStruct.new(attributes.merge(:name => branch_name, :number => build_hash["buildNumber"]))
        end
      end
    end

    def build(job_name, build_number, attributes = {})
      build_json = get "/job/#{job_name}/#{build_number}"
      return OpenStruct.new unless build_json.present?

      branch_name, sha = branch_name_from_build_json(build_json, build_number)

      OpenStruct.new(attributes).tap do |build|
        build.job_name      = job_name
        build.build_number  = build_number.to_i
        build.result        = build_json["result"]
        build.built_at      = parse_time_from_build_id(build_json["id"])
        build.building      = build_json["building"]
        build.branch_name   = branch_name
        build.sha           = sha
      end
    end

    # jenkins build id time format YYYY-MM-DD_hh-mm-ss
    # example 012-02-27_18-20-28
    def parse_time_from_build_id(api_build_id)
      date, time = api_build_id.split('_')
      Time.parse([date, time.gsub(/-/, ":")].join(' '))
    end

    def get(path = nil)
      response = connection.get(URI::escape("#{path}/api/json"))
      if response.success?
        response.body
      else
        nil
      end
    end


    def connection
      @connection = Faraday.new(url: @configuration.host, port: 80) do |conn|
        # conn.request :basic_auth, @configuration.user_name, @configuration.token
        conn.request :json

        conn.response :json, :content_type => /\bjson|javascript$/
        conn.response :logger unless Rails.env.test?

        conn.use :instrumentation
        conn.adapter Faraday.default_adapter
      end
    end

    protected

    def branch_name_from_build_json(build_json, build_number)
      actions_json = build_json["actions"] || []
      return nil unless actions_json.any?
      actions_metadata_json = actions_json[1]
      return nil unless actions_metadata_json.any?
      branches_json = actions_metadata_json["buildsByBranchName"]
      return nil unless branches_json.any?

      branch_json = branches_json.select {|branch_name,hash|
        hash["buildNumber"] == build_number && !exclude_branch?(branch_name)
      }

      branch_name = branch_json.keys.first
      sha = branch_json[branch_name]["revision"]["SHA1"]
      [branch_name, sha]
    end

    def exclude_branch?(branch_name)
      BRANCHES_TO_EXCLUDE.include?(branch_name)
    end

  end
end