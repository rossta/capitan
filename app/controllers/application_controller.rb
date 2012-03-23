class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate!

  def authenticate!
    redirect_to sign_in_path unless signed_in?
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
