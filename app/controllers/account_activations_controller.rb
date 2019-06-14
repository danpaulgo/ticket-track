class AccountActivationsController < ApplicationController

	def edit
		logout if logged_in?
		user = User.find_by(email: params[:email])
		# binding.pry
		if user && user.authenticated?(:activation, params[:id])
			user.activate
			flash[:notice] = "Account successfully activated"
			redirect_to login_path
		else
			flash[:error] = "Incorrect activation token and/or e-mail"
			redirect_to root_path
		end
	end

end
