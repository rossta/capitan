class SessionsController < ApplicationController
  skip_before_filter :authenticate_team_member!

  def new
  end

	def create
		warden.authenticate!
    flash[:success] = "Welcome!"
		redirect_to root_url
	end

	def destroy
		warden.logout
    flash[:notice] = "Logged out!"
  	redirect_to root_url
	end

  def failure
    raise params.inspect
  end

end
