class HomeController < ApplicationController

  def show
    flash[:notice] = warden.message if warden.message
    @stacks = StackDecorator.decorate(Stack.order(:name))
    @jobs = JobDecorator.decorate(Job.enabled.order(:name))
  end

end