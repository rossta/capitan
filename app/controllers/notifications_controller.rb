class NotificationsController < ApplicationController
  skip_before_filter :authenticate!, :only => :create
  skip_before_filter :verify_authenticity_token, :only => :create

  def show
    
  end

  def create
    @notification = Notification.new(params)
    @notification.process!
    head :ok    
  end

  private

end