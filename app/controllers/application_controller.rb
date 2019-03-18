class ApplicationController < ActionController::Base

	def home
		if session[:user_id]
			redirect_to User.find(session[:user_id])
		end	
	end

	def current_user
	  @current_user ||= User.find(session[:user_id])
	end

end
