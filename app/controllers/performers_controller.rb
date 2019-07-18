class PerformersController < ApplicationController

 before_action :logged_out_redirect, :inactive_redirect
 before_action :non_admin_redirect, only: [:edit, :update, :destroy]
 before_action :set_object, :nil_object_redirect, only: [:show, :edit, :update, :destroy]

 def index
 	@performers = Performer.all.order(name: :asc)
 end

 def show
 	@upcoming_events = @performer.events.where("date >= ?", Date.today).order(date: :asc).limit(10)
 end

 def edit
 end

 def update
 	if @performer.update(performer_params)
 			flash[:notice] = 'Performer was successfully updated'
      redirect_to @performer
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
