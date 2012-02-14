require 'faraday'
require 'faraday_middleware'

module Capitan
  module Jenkins
    module API
      extend self

      def connection
        @connection = Faraday.new(url: Jenkins::Config.host, port: 8080) do |conn|
          conn.request :basic_auth, Jenkins::Config.user_name, Jenkins::Config.token
          conn.request :json

          conn.response :json, :content_type => /\bjson|javascript$/
          conn.response :logger

          conn.use :instrumentation
          conn.adapter Faraday.default_adapter
        end
      end

      def get(path)
        connection.get(json_url(path)).body
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

      def json_url(path = '')
        "#{path}/api/json"
      end

    end
  end
end