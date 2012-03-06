module Github

  class Configuration
    include ActiveSupport::Configurable
    config_accessor :api_host, :raw_host, :org

    API_HOST = 'https://api.github.com'
    RAW_HOST = 'https://raw.github.com'

    def configure
      yield self
    end

    def api_host
      self.config.api_host || API_HOST
    end

    def raw_host
      self.config.raw_host || RAW_HOST
    end

    def team_members_path
      raise "Organization not configured" unless config.org.present?
      "/orgs/#{org}/members"
    end
  end


end