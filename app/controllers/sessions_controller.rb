class SessionsController < ApplicationController
  def new
  	
  end

  def create
  end

  def destroy

  end

  private

  	def session_params
	    params.require(:session).permit(:email, :password, :remember_me)
	  end
end
