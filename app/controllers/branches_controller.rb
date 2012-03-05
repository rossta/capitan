class BranchesController < ApplicationController

  def show
    @job = Job.find(params[:job_id])
    @branch = BranchDecorator.new(@job.branches.find(params[:id]))
  end
end
