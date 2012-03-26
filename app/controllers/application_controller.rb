class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_opensesame!

  def current_user
    current_opensesame_user
  end
  helper_method :current_user

  def signed_in?
    !!current_user
  end
  helper_method :signed_in?

end
