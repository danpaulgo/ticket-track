class EventsController < ApplicationController
  before_action :set_object, only: [:show, :edit, :update, :destroy]
  before_action :valid_admin, only: [:edit, :update, :destroy]
  before_action :valid_user, only:[:index, :show, :new, :create]
  before_action :matching_user, only: [:index, :show]

  # GET /events
  # GET /events.json
  def index
    set_venue
    set_performer
    if !@user.nil?
      @events = @user.events.uniq
      @title = "My Events"
    elsif !@performer.nil?
      @events = @performer.events
      @title = "#{@performer.name} Events"
    elsif !@venue.nil?
      @events = @venue.events
      @title = "#{@venue.name} Events"
    else
      @events = Event.all
      @title = "All Events"
    end
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  def show
    redirect_to current_user if @user.nil?
    @recent_transactions = @event.transactions.where(user: @user).order(date: :desc).limit(10)
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
      redirect_to events_path, notice: 'Event was successfully updated.'
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

  private

    def matching_user
      set_user
      redirect_to current_user if !@user.nil? && @user != current_user && !current_user.admin?
    end

    def set_venue
      @venue = Venue.find_by(id: params[:venue_id]) if params[:venue_id]
    end

    def set_performer
      @performer = Performer.find_by(id: params[:performer_id]) if params[:performer_id]
    end

end
