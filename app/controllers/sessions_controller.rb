class SessionsController < ApplicationController
  skip_before_filter :authenticate_user!

  def new
  end

	def create
		warden.authenticate!
		redirect_to root_url, notice: "Welcome!"
	end

	def destroy
		warden.logout
  	redirect_to root_url, notice: "Logged out!"
	end

end
