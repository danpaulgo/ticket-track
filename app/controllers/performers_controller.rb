class PerformersController < ApplicationController

 before_action :valid_admin, only: [:index, :edit, :update, :destroy]
 before_action :valid_user, only: [:show]

 def index
 end

 def show
 end

 def edit
 end

 def update
 end

 def destroy
 end

end
