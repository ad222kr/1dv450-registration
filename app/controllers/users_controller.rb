class UsersController < ApplicationController
  before_action :fetch_user, only: [:show, :edit, :update, :check_if_correct_user]
  before_action :check_if_logged_in, only: [:show, :edit, :update]
  before_action :check_if_correct_user, only: [:show, :edit, :update]
  before_action :check_if_admin, only: [:index]
  before_action :redirect_to_profile_if_logged_in, only: [:new]



  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the API-key registration app!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def index
    @users = User.all
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Din profil uppdaterades!"
      redirect_to @user
    elsif
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def fetch_user
      @user = User.find(params[:id])
    end

    def check_if_logged_in
      unless logged_in?
        store_location
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end

    def check_if_correct_user
      redirect_to root_path unless @user == current_user
    end

    def check_if_admin
      redirect_to root_path unless current_user.admin?
    end

    def redirect_to_profile_if_logged_in
      redirect_to user_path(current_user) if logged_in?
    end

end
