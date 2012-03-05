module Github

  class Configuration
    include ActiveSupport::Configurable
    config_accessor :host, :org

    HOST = 'https://api.github.com'

    def configure
      yield self
    end

    def host
      self.config.host || HOST
    end

    def team_members_path
      raise "Organization not configured" unless config.org.present?
      "/orgs/#{org}/members"
    end
  end


end