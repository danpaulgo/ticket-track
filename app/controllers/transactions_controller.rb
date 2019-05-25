class TransactionsController < ApplicationController
  
  before_action :authorized_user
  before_action :matching_user, only: [:show, :edit, :update, :destroy]
  

  # GET /transactions
  # GET /transactions.json
  def index
    if params[:user_id]
      set_user
      if params[:event_id]
        set_event
        @transactions = @user.transactions.where(event: @event)
        @subtitle = @event.name
      else
        @transactions = User.find_by(id: params[:user_id]).transactions
      end
    else
      redirect_to current_user
    end
  end

  # GET /transactions/new
  def new
    set_events
    set_sources
    @transaction = Transaction.new
  end

  def show

  end

  # GET /transactions/1/edit
  def edit
    set_sources
    set_events
    @event_id = @transaction.event.id
  end

  # POST /transactions
  # POST /transactions.json
  def create

  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    if @transaction.update(object_params)
      index_redirect('Transaction was successfully updated')
    else
      render :edit
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    index_redirect('Transaction was successfully deleted')
  end

  private

    def matching_user
      set_object
      redirect_to current_user if @transaction && (@transaction.user != @user)
    end

    def set_event
      @event = Event.find_by(id: params[:event_id]) if params[:event_id]
    end

    def authorized_user
      if current_user.nil?
        redirect_to root_path
      else
        set_user
        redirect_to current_user unless (@user == current_user) || current_user.admin?
      end
    end

    def index_redirect(notice)
      flash[:notice] = notice
      if current_user.admin?
        redirect_to user_transactions_path(@user)
      else
        redirect_to user_transactions_path(current_user)
      end
    end

    def set_events
      @events = Event.order(date: :asc).map{|e| [e.name, e.id]}
    end

    def set_sources
      @sources = TransactionSource.order(name: :asc).map{|s| [s.name, s.id]}.unshift ["Add Source", 0]
    end

    def params_hash
      params_hash = object_params.to_h
      if params_hash[:transaction_source_id] == "0" && !params[:new_source].blank?
        new_source = TransactionSource.find_or_create(params[:new_source])
        params_hash[:transaction_source_id] = new_source.id
      end
      params_hash
    end

end
