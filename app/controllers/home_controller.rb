class HomeController < ApplicationController

  def show
    @jobs = Job.order(:name)

  end

end