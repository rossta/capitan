class JobsController < ApplicationController

  def show
    @job = JobDecorator.new(Job.find(params[:id]))
  end
end