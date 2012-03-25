module ApplicationHelper

  def enable_challengepost_authentication?
    Capitan::Application.config.enable_challengepost_authentication
  end
end
