class EventsController < ApplicationController
  before_action :set_object, only: [:edit, :update, :destroy]
  before_action :valid_admin, only: [:edit, :update, :destroy]
  before_action :valid_user, only:[:index, :new, :create]


  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(object_params)
    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    if @event.update(object_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy if @event
    redirect_to events_url, notice: 'Event was successfully destroyed.'
  end

end
