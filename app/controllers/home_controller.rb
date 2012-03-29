class HomeController < ApplicationController

  def show
    flash[:notice] = warden.message if warden.message
    @jobs = JobDecorator.decorate(Job.enabled.order(:name))
  end

end