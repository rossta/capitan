require 'faraday'
require 'faraday_middleware'
require 'ostruct'

module Github
	extend self

  autoload :Configuration, 'github/configuration'

  delegate :configure, :to => :configuration

	def team_members
		get configuration.team_members_path
	end

	def team_member_ids
		team_members.map { |m| m['id'] }.compact
	end

	def team_member?(team_member_id)
		team_member_ids.include?(team_member_id)
	end

  def configuration
    @_configuration ||= Configuration.new
  end

  def reset_configuration
    @_configuration = nil
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
		@connection ||= Faraday.new(url: configuration.host) do |conn|
			conn.request :json

			conn.response :json, :content_type => /\bjson|javascript$/
			conn.response :logger unless Rails.env.test?

			conn.use :instrumentation
			conn.adapter Faraday.default_adapter
		end
	end

end