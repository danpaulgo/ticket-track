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
	  @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
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

    def object_params
    	attributes = object_attributes
    	attributes.delete("id")
    	attributes.delete("created_at")
    	attributes.delete("updated_at")
    	attributes.delete("admin")
    	attributes.push("password", "password_confirmation") if controller_name == "users"
    	params.require(:"#{object_type}").permit(attributes)
    end

end
