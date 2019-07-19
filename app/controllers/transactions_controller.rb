class TransactionsController < ApplicationController
  
  before_action :logged_out_redirect, :inactive_redirect, :unauthorized_redirect
  before_action :set_object, :mismatch_redirect, only: [:show, :edit, :update, :destroy]
  

  # GET /transactions
  # GET /transactions.json
  def index
    @order_var = "ASC"
    set_order_var
    set_filter_var
    if params[:user_id]
      set_user
      if params[:event_id]
        set_event
        @transactions = @user.transactions.where(event: @event).where(@filter_string).order(date: @order_var)
        @subtitle = @event.name
      else
        @transactions = User.find_by(id: params[:user_id]).transactions.where(@filter_string).order(date: @order_var)
      end
    else
      redirect_to current_user
    end
  end

  # GET /transactions/new
  def new
    redirect_to current_user unless @user
    set_events
    set_sources
    @transaction = Transaction.new
  end

  def show
    @notes = @transaction.notes.blank? ? "N/a" : @transaction.notes
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
    @transaction = Transaction.new(params_hash)
    if @transaction.save
      flash[:success] = "Transaction successfully created"
      redirect_to user_transaction_path(@user, @transaction)
    else
      delete_created_source
      set_events
      set_sources
      @event_id = @transaction.event.id if @transaction.event
      render :new
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    if @transaction.update(params_hash)
      flash[:notice] = "Transaction was successfully updated"
      redirect_to user_transaction_path(@user, @transaction)
    else
      delete_created_source
      set_events
      set_sources
      @event_id = @transaction.event.id if @transaction.event
      render :edit
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    flash[:notice] = "Transaction was successfully deleted"
    redirect_to user_transactions_path(@user)
  end

  private 

    def set_event
      @event = Event.find_by(id: params[:event_id]) if params[:event_id]
    end

    def authorized_user
      set_user
      (@user == current_user) || current_user.admin? 
    end

    def unauthorized_redirect
      if !authorized_user
        redirect_to current_user
      end
    end

    def mismatch_redirect
      if @transaction.nil? || @user.nil? || (@transaction.user != @user)
        redirect_to current_user and return
      end
    end

    def set_events
      @events = Event.order(date: :asc).map{|e| [e.name, e.id]}
    end

    def set_sources
      @sources = TransactionSource.order(name: :asc).map{|s| [s.name, s.id]}.unshift ["Add Source", 0]
    end

    def set_order_var
      if params[:order_by].nil?
        @order_var = "desc"
      else
        @order_var = params[:order_by]
      end
    end

    def set_filter_var
      if params[:filter_by] == "Purchases"
        @filter_string = "direction = 'Purchase'"
      elsif params[:filter_by] == "Sales"
        @filter_string = "direction = 'Sale'"
      end
    end

    def params_hash
      params_hash = object_params.to_h
      params_hash[:user_id] = @user.id
      if params_hash[:transaction_source_id] == "0" && !params[:new_source].blank?
        new_source = TransactionSource.find_or_create(params[:new_source])
        params_hash[:transaction_source_id] = new_source.id
      end
      params_hash
    end

    def delete_created_source
      if !TransactionSource.last.nil?
        TransactionSource.last.delete if TransactionSource.last.transactions.empty?
      end
    end

end
