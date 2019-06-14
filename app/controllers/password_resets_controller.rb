class PasswordResetsController < ApplicationController

	def new
		redirect_to current_user if logged_in?
	end

	def edit

	end

	def create
		@user = User.find_by(email: params[:password_reset][:email].downcase)
		if @user

		else
			flash[:error] = "User does not exist"
			render :new
		end
	end	

	def update

	end
end
