class SessionsController < ApplicationController
  def new
  	redirect_to current_user if logged_in?
  end

  def create
  	@user = User.find_by(email: params[:session][:email])
  end

  def destroy
  	logout
  	redirect_to root_path
  end

  private

  	def session_params
	    params.require(:session).permit(:email, :password, :remember_me)
	  end
end
