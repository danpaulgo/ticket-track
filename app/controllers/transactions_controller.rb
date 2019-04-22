class TransactionsController < ApplicationController
  
  before_action :authorized_user
  before_action :matching_user, only: [:edit, :update, :destroy]
  

  # GET /transactions
  # GET /transactions.json
  def index
    if params[:user_id]
      @transactions = User.find_by(id: params[:user_id]).transactions
    else
      @transactions = Transaction.all
    end
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(object_params)
    @transaction.user_id = current_user.id
    if @transaction.save
      redirect_to user_transactions_path(current_user), notice: 'Transaction was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    if @transaction.update(transaction_params)
      redirect_to @transaction, notice: 'Transaction was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    redirect_to transactions_url, notice: 'Transaction was successfully destroyed.'
  end

  private

    def set_user
      @user ||= User.find_by(id: params[:user_id]) if params[:user_id]
    end

    def matching_user
      set_object
      redirect_to current_user if @transaction && (@transaction.user != @user)
    end

    def authorized_user
      set_user
      if current_user.nil?
        redirect_to root_path
      else
        redirect_to current_user unless (@user == current_user) || current_user.admin?
      end
    end

end
