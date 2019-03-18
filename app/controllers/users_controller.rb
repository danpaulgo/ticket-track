class UsersController < ApplicationController
  before_action :set_user, :matching_user, only: [:show, :edit, :update, :destroy]
  before_action :valid_admin, only: [:index]
  before_action :valid_new_user, only: [:new, :create]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
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
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :birthdate)
    end

    def valid_user
      redirect_to root_path if session[:user_id].nil?
    end

    def matching_user 
      unless valid_user
        redirect_to current_user unless @user == current_user || current_user.admin?
      end
    end

    def valid_admin
      unless valid_user
        redirect_to current_user unless current_user.admin?
      end
    end

    def valid_new_user
      redirect_to User.find_by(id: session[:user_id]) unless session[:user_id].nil?
    end
end
