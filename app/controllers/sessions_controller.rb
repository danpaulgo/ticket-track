class SessionsController < ApplicationController
  
  before_action :redirect_logged_in_user, only: [:new, :create, :fb_create]

  def new
    @email = nil
    @password = nil
  end

  def create
  		set_user
  		set_password
  		if @user.nil?
        @email = nil
        @password = nil
        flash[:error] = "User does not exist"
  			render :new
      elsif @user.facebook_user?
        redirect_to "/auth/facebook"
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

  def fb_create
    if auth.nil?
      flash[:error] = "Invalid credentials"
      redirect_to root_path
    else
      user = User.find_by(email: auth[:info][:email])
      if !user.nil?
        login(user)
        redirect_to user
      else
        user = User.create(name: auth[:info][:name], email: auth[:info][:email], facebook_id: auth[:uid], activated: true, admin: false)
        login(user)
        redirect_to user
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

    def auth
      request.env['omniauth.auth']
    end

    def redirect_logged_in_user
      redirect_to current_user if logged_in?
    end

end
