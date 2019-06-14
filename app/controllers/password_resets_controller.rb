class PasswordResetsController < ApplicationController

	before_action :redirect_logged_in_users
	before_action :set_user_by_email, except: [:new]
	before_action :invalid_email_redirect, only: [:edit, :update]
	before_action :invalid_token_redirect, only: [:edit, :update]
	before_action :expired_token_redirect, only: [:edit, :update]

	def new
		# redirect_to current_user if logged_in?
	end

	def edit	
		# set_user_by_email
		invalid_email_redirect
		invalid_token_redirect
	end

	def create
		# binding.pry
		# set_user_by_email
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
		if params[:user][:password].empty?
			@user.errors.add(:password, "can't be empty")
      render :edit
    elsif @user.update_attributes(object_params("users"))
      flash[:success] = "Password successfully updated"
      redirect_to login_path
    else
    	render :edit
    end
	end

	private

	def redirect_logged_in_users
		redirect_to current_user and return if logged_in?
	end

	def invalid_email_redirect
		if @user.nil?
			flash[:error] = "Invalid email"
			redirect_to new_password_reset_path and return 
		end
	end

	def invalid_token_redirect
		unless @user && @user.authenticated?(:reset, params[:id])
			flash[:error] = "Invalid token"
			redirect_to root_path and return 
		end
	end

	def expired_token_redirect
		if Time.now - @user.reset_sent_at > 2.hours
			flash[:error] = "Expired token"	
			redirect_to root_path and return 
		end
	end

	def set_user_by_email
		@user = User.find_by(email: params[:email].downcase)
	end

end
