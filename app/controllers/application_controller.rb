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

end
