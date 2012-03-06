module Github
	extend self

  autoload :Configuration, 'github/configuration'
  autoload :API, 'github/api'
  autoload :Raw, 'github/raw'

  delegate :configure, :to => :configuration
  delegate :team_members, :team_member_ids, :team_member?, :to => :api

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

  def raw
    @_raw ||= Raw.new(configuration)
  end

end