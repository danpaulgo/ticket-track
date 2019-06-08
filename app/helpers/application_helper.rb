module ApplicationHelper

	def logged_in?
		!session[:user_id].nil?
	end

	def current_user
	  # @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
	  if user_id = session[:user_id]
	  	@current_user ||= User.find_by(id: user_id)
	  elsif user_id = cookies.signed[:user_id]
	  	user = User.find_by(id: user_id)
	  	remember_token = cookies[:remember_token]
	  	if user && user.authenticated?(remember_token)
	  		@current_user = user
	  	else
	  		@current_user = nil
	  	end
	  end
	end
	
end
