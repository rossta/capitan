class HomeController < ApplicationController

  def show
    @jobs = JobDecorator.decorate(Job.order(:name))
  end

end