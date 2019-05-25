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
    set_performers
    set_venues
  end

  def show
    redirect_to current_user if @user.nil?
    @recent_transactions = @event.transactions.where(user: @user).order(date: :desc).limit(10)
  end

  # GET /events/1/edit
  def edit
    @performer_id = @event.performer.id
    @venue_id = @event.venue.id
    set_performers
    set_venues
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params_hash)
    if @event.save
      flash[:success] = "Event successfully created"
      redirect_to events_path
    else
      delete_created_performer
      @performer_id = @event.performer.id if @event.performer
      @venue_id = @event.venue.id if @event.venue
      set_performers
      set_venues
      render :new
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    if @event.update(params_hash)
      flash[:success] = "Event successfully updated"
      redirect_to events_path
    else
      delete_created_performer
      @performer_id = @event.performer.id if @event.performer
      @venue_id = @event.venue.id if @event.venue
      set_performers
      set_venues
      render :edit
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy if @event
    flash[:notice] = 'Event was successfully destroyed'
    redirect_to events_url
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

    def params_hash
      params_hash = object_params.to_h
      if params_hash[:performer_id] == "0" && !params[:new_performer].blank?
        new_performer = Performer.find_or_create(params[:new_performer])
        params_hash[:performer_id] = new_performer.id
      end
      params_hash
    end

    def set_venues
      @venues = Venue.order(name: :asc).map{|v| [v.extended_name, v.id]}
    end

    def set_performers
      @performers = Performer.order(name: :asc).map{|p| [p.name, p.id]}.unshift ["Add Performer", 0]
    end

    def delete_created_performer
      if !Performer.last.nil?
        Performer.last.delete if Performer.last.events.empty?
      end
    end

end
