class JobsController < ApplicationController

  respond_to :html, :json

  def index
    @jobs = JobDecorator.decorate(Job.order(:name))
    respond_with @jobs
  end

  def show
    @job = JobDecorator.new(Job.find(params[:id]))
    respond_with @job
  end

end