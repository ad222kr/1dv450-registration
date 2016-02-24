class UsersController < ApplicationController
  before_action :fetch_user, only: [:show, :edit, :update]
  before_action :check_if_correct_user, only: [:show, :edit, :update]
  before_action :redirect_to_profile_if_logged_in, only: [:new]



  def show
    if @user.admin?
      @apps = App.all
    else
      @apps = @user.apps
    end
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

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Your profile was updated!"
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





end
