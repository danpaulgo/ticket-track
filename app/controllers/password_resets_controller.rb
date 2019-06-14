class PasswordResetsController < ApplicationController

	before_action :redirect_logged_in_users

	def new
		# redirect_to current_user if logged_in?
	end

	def edit

	end

	def create
		@user = User.find_by(email: params[:password_reset][:email].downcase)
		if @user
			@user.create_reset_digest
			@user.send_password_reset_email
			flash[:notice] = "E-mail sent with password reset instructions"
			redirect_to root_url
		else
			flash[:error] = "User does not exist"
			render :new
		end
	end	

	def update

	end

	private

	def redirect_logged_in_users
		redirect_to current_user and return if logged_in?
	end

end
