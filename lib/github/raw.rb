require 'faraday'
require 'faraday_middleware'
require 'ostruct'

module Github
  class Raw

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

    def connection
      @connection ||= Faraday.new(url: @configuration.raw_host) do |conn|
        conn.request :json

        conn.response :json, :content_type => /text$/
        conn.response :logger unless Rails.env.test?

        conn.use :instrumentation
        conn.adapter Faraday.default_adapter
      end
    end

  end
end