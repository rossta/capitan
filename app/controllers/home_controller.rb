class HomeController < ApplicationController

  def show
    flash[:notice] = warden.message if warden.message
    @jobs = JobDecorator.decorate(Job.order(:name))
  end

end