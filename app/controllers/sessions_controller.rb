class SessionsController < ApplicationController
  def new
    @email = nil
    @password = nil
  	redirect_to current_user if logged_in?
  end

  def create
  	if logged_in?
  		redirect_to current_user 
  	else
  		set_user
  		set_password
  		if @user.nil?
        @email = nil
        @password = nil
        flash[:error] = "User does not exist"
  			render :new, notice: "User does not exist"
  		elsif !@user.authenticate(@password)
        @password = nil
        flash[:error] = "Invalid email and/or password"
  			render :new
  		else
        flash.clear
  			login(@user)
        if remember?
          remember_user(@user)
        end
  			redirect_to @user
  		end
  	end
  end

  def destroy
    if logged_in?
      current_user.forget
  	  logout
    end
  	redirect_to root_path
  end

  private

	  def set_user
      @email = params[:email]
	  	@user = User.find_by(email: @email)
	  end

	  def set_password
	  	@password = params[:password]
	  end

    def remember?
      params[:remember_me] == "1" ? true : false
    end

    def remember_user(user)
      @user.remember
      remember_cookies(@user, user.remember_token)
    end

end
