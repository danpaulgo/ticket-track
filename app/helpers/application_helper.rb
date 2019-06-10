module ApplicationHelper

	def logged_in?
		!session[:user_id].nil? && !!User.exists(session[:user_id])
	end

	def current_user
	  if user_id = session[:user_id]
	  	@current_user = User.find_by(id: user_id)
	  elsif user_id = cookies.signed[:user_id]
	  	user = User.find_by(id: user_id)
	  	remember_token = cookies[:remember_token]
	  	if user && user.authenticated?(:remember, remember_token)
	  		login(user)
	  		@current_user = user
	  	else
	  		@current_user = nil
	  	end
	  end
	end
	
end
