class NotificationsController < ApplicationController
  skip_before_filter :authenticate_team_member!, :only => :create
  skip_before_filter :verify_authenticity_token, :only => :create

  def show

  end

  def create
    Rails.logger.warn "[[[[JENKINS NOTIFICATION]]]]"
    Rails.logger.warn params.inspect
    @notification = Notification.new(params)
    @notification.process!
    head :ok
  end

  private

end