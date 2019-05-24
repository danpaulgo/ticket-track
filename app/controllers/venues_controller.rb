class VenuesController < ApplicationController
  
  before_action :set_object, only: [:show, :edit, :update, :destroy]
  before_action :valid_admin, only: [:edit, :update, :destroy]
  before_action :valid_user, only: [:index, :show, :new, :create]

  # GET /venues
  # GET /venues.json
  def index
    @venues = Venue.all
  end

  # GET /venues/1
  # GET /venues/1.json
  def show
    @upcoming_events = @venue.events.where("date >= ?", Date.today).order(date: :asc).limit(10)
  end

  # GET /venues/new
  def new
    @venue = Venue.new
  end

  # GET /venues/1/edit
  def edit
  end

  # POST /venues
  # POST /venues.json
  def create
    @venue = Venue.new(object_params)
    if @venue.save
      flash[:notice] = 'Venue was successfully created'
      redirect_to @venue
    else
      render :new
    end
  end

  # PATCH/PUT /venues/1
  # PATCH/PUT /venues/1.json
  def update
      if @venue.update(object_params)
        flash[:notice] = 'Venue was successfully updated'
        redirect_to @venue
      else
        render :edit
      end
  end

  # DELETE /venues/1
  # DELETE /venues/1.json
  def destroy
    @venue.destroy if @venue
    flash[:notice] = 'Venue was successfully deleted'
    redirect_to venues_url
  end

end
