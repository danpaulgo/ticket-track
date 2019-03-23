class SessionsController < ApplicationController
  def new
  	redirect_to current_user if logged_in?
  end

  def create
  	if logged_in?
  		redirect_to current_user 
  	else
  		set_user
  		set_password
  		if @user.nil?
  			render :new, notice: "User does not exist"
  		elsif !@user.authenticate(@password)
  			render :new, notice: "Invalid email and/or password"
  		else
  			login(@user)
  			redirect_to @user
  		end
  	end
  end

  def destroy
  	logout
  	redirect_to root_path
  end

  private

  	def session_params
	    params.require(:session).permit(:email, :password, :remember_me)
	  end

	  def set_user
	  	@user = User.find_by(email: params[:session][:email])
	  end

	  def set_password
	  	@password = params[:session][:password]
	  end

end
