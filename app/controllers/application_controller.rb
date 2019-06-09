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

		def valid_user
      unless inactive_user
        unless logged_in?
          logout
          redirect_to root_path
        end
      end
    end

    def inactive_user
      if logged_in? && !current_user.activated?
        flash[:notice] = "Please activate your account"
        logout
        redirect_to root_path
      end
    end

    def valid_admin
      unless valid_user
        redirect_to current_user unless current_user.admin?
      end
    end

    def object_type
    	controller_name.singularize
    end

    def object_attributes
    	object_type.spaceless_title.constantize.new.attributes.keys
    end

    def set_object
    	obj = instance_variable_set(:"@#{object_type}", object_type.spaceless_title.constantize.find_by(id: params[:id]))
    	redirect_to current_user if obj.nil?
    end

    def set_user
      @user ||= User.find_by(id: params[:user_id]) if params[:user_id]
    end

    def object_params
    	attributes = object_attributes
    	attributes.delete("id")
    	attributes.delete("created_at")
    	attributes.delete("updated_at")
    	attributes.delete("admin")
    	attributes.push("password", "password_confirmation") if controller_name == "users"
    	params.require(:"#{object_type}").permit(attributes)
    end

    def remember_cookies(user, token)
      cookies[:remember_token] = {value: token, expires: 1.month.from_now.utc}
      cookies.signed[:user_id] = user.id
    end

end
