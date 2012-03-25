class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_team_member!

  def authenticate_team_member!
    warden.authenticate!(:scope => :team_member)
  end

  def warden
    env['warden']
  end

  def current_user
    warden.user(:scope => :team_member)
  end
  helper_method :current_user

  def signed_in?
    !!current_user
  end
  helper_method :signed_in?

end
