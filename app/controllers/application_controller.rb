class ApplicationController < ActionController::Base

	def home
		if session[:user_id]
			redirect_to User.find(session[:user_id])
		end	
	end

	def login(user)
		session[:user_id] = user.id
	end

	def logout
		session.clear
	end

	def current_user
	  @current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def logged_in?
		!session[:user_id].nil?
	end

	protected

		def valid_user
      redirect_to root_path if session[:user_id].nil?
    end

    def valid_admin
      unless valid_user
        redirect_to current_user unless current_user.admin?
      end
    end

    def set_object
    	type = controller_name.singularize
    	instance_variable_set(:"@#{type}", type.capitalize.constantize.find_by(id: params[:id]))
    end

end
