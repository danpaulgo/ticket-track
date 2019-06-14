class ApplicationController < ActionController::Base

  include ApplicationHelper

	def home
    if user = User.exists(session[:user_id])
			redirect_to user if user.activated?
		end	
	end

  def about

  end

  def contact

  end

	def login(user)
		session[:user_id] = user.id
	end

	def logout
		session.clear
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
	end

	protected

    def active_user?
      logged_in? && current_user.activated?
    end

    def valid_admin?
      active_user? && current_user.admin?
    end

    def logged_out_redirect
      if !logged_in?
        flash[:error] = "Please log in"
        redirect_to root_path and return
      end
    end

    def inactive_redirect
      if !active_user?
        flash[:error] = "Please activate your account"
        redirect_to root_path and return
      end
    end

    def non_admin_redirect
      if !valid_admin?
        flash[:error] = "Unauthorized request"
        redirect_to current_user and return
      end
    end

    def object_type(controller_type = controller_name)
    	controller_type.singularize
    end

    def object_attributes(controller_type = controller_name)
    	object_type(controller_type).spaceless_title.constantize.new.attributes.keys
    end

    def set_object
    	obj = instance_variable_set(:"@#{object_type}", object_type.spaceless_title.constantize.find_by(id: params[:id]))
    	# redirect_to current_user and return if obj.nil?
    end

    def nil_object_redirect
      if instance_variable_get(:"@#{object_type}").nil?
        redirect_to current_user and return
      end
    end

    def set_user
      @user ||= User.find_by(id: params[:user_id]) if params[:user_id]
    end

    def object_params(controller_type = controller_name)
    	attributes = object_attributes(controller_type)
      blacklist = [
        "id", 
        "created_at", 
        "updated_at", 
        "admin", 
        "activated", 
        "activated_at", 
        "password_digest", 
        "remember_digest",
        "activation_digest",
        "reset_digest",
        "reset_sent_at"] # SHORTEN FOR BLOG POST
      blacklist.each{|item| attributes.delete(item)}
    	attributes.push("password", "password_confirmation") if controller_type == "users"
    	params.require(:"#{object_type(controller_type)}").permit(attributes)
    end

    def remember_cookies(user, token)
      cookies[:remember_token] = {value: token, expires: 1.month.from_now.utc}
      cookies.signed[:user_id] = user.id
    end

end
