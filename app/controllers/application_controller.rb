class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_team_member!

  def current_user
    current_team_member
  end
  helper_method :current_user

  def signed_in?
    !!current_user
  end
  helper_method :signed_in?

end
