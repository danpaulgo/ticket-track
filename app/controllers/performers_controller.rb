class PerformersController < ApplicationController

 before_action :valid_admin, only: [:edit, :update, :destroy]
 before_action :valid_user, only: [:index, :show]
 before_action :set_object, only: [:show, :edit, :update, :destroy]

 def index
 end

 def show
 end

 def edit
 end

 def update
 	if @performer.update(performer_params)
      redirect_to @performer, notice: 'Performer was successfully updated.'
    else
      render :edit
    end
 end

 def destroy
 	@performer.destroy if @performer
 	redirect_to performers_path
 end

 private

 	def performer_params
 		params.require(:performer).permit(:name)
 	end

end
