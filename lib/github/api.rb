require 'faraday'
require 'faraday_middleware'
require 'ostruct'

module Github

  class API

    def initialize(configuration)
      @configuration = configuration
    end

    def get(path = nil)
      response = connection.get(path)
      if response.success?
        response.body
      else
        nil
      end
    end

    protected

    def connection
      @connection ||= Faraday.new(url: @configuration.api_host) do |conn|
        conn.request :json

        conn.response :json, :content_type => /\bjson|javascript$/
        conn.response :logger unless Rails.env.test?

        conn.use :instrumentation
        conn.adapter Faraday.default_adapter
      end
    end
  end
end

# organization = Github::Organization.new('challengepost')
# organization.team_members
# organization.team_member?(id)
# Github::Organization.new('challengepost').team_members.find(id)
# organization.team_members.find(id)
