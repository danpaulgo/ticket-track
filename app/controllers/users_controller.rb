class UsersController < ApplicationController
  
  before_action :logged_out_redirect, :inactive_redirect, except: [:new, :create]
  before_action :non_admin_redirect, only: [:index, :admins]
  before_action :existing_user_redirect, only: [:new, :create]
  before_action :set_object, :nil_object_redirect, :mismatching_redirect, only: [:show, :edit, :update, :destroy]

  # GET /users
  def index
    @users = User.all
    .order(name: :asc)
    .paginate(page: params[:page], per_page: 20)
  end

  def admins
    @users = User.admins
    .order(name: :asc)
    .paginate(page: params[:page], per_page: 20)
    render :index
  end

  # GET /users/1
  def show
    @upcoming_events = @user.events.where(['events.date >= ?', Date.today]).order(:date).uniq[0..9]
    @recent_transactions = @user.transactions.order(date: :desc).limit(10)
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
      @user.admin = false
      if @user.save
        @user.send_activation_email
        flash[:notice] = 'Please check email for account activation link'
        redirect_to root_path
      else
        render :new
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    params_hash = object_params.to_h
    if params_hash[:password].blank? && params_hash[:password_confirmation].blank?
      params_hash.except!(:password)
      params_hash.except!(:password_confirmation)
    end
    # binding.pry
    if @user.update(params_hash)
      flash[:notice] = "User was successfully updated"
      redirect_to @user
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    flash[:notice] = 'User was successfully deleted'
    if @user == current_user
      @user.destroy
      logout
      redirect_to root_path
    else
      @user.destroy
      redirect_to users_url
    end
  end

  private

    def mismatching_redirect
      if @user != current_user && !current_user.admin?
        redirect_to current_user and return
      end
    end

    def existing_user_redirect
      if logged_in?
        redirect_to current_user and return
      end
    end


end
