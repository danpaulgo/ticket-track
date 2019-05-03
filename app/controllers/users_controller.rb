class UsersController < ApplicationController
  
  before_action :valid_admin, only: [:index]
  before_action :valid_new_user, only: [:new, :create]
  before_action :set_object, :matching_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
    @upcoming_events = @user.events.where(['date >= ?', Date.today]).order(:date).uniq[0..9]
    @recent_transactions = @user.transactions.order(created_at: :desc).limit(10)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    if session[:user_id].nil?
      @user = User.new(object_params)
      if @user.save
        login(@user)
        redirect_to @user, notice: 'User was successfully created.'
      else
        render :new
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(object_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    notice = 'User was successfully destroyed.'
    if @user == current_user
      logout
      redirect_to root_path, notice: notice
    else
      redirect_to users_url, notice: notice
    end
  end

  private

    def matching_user 
      unless valid_user
        redirect_to current_user unless @user == current_user || current_user.admin?
      end
    end

    def valid_new_user
      redirect_to User.find_by(id: session[:user_id]) unless session[:user_id].nil?
    end
end
