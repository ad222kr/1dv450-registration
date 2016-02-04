class AppsController < ApplicationController
  before_action :fetch_app, only: [:show, :destroy]


  def show

  end

  def new
    @app = App.new
    @user = current_user
  end

  def create

    @app = App.create(app_params)
    @app.user = current_user

    if @app.save
      flash[:success] ="Application registered!"
      redirect_to user_path(@app.user)
    else
      render 'new'
    end

  end

  def index
    @apps = App.all
  end

  def destroy
    App.find(params[:id]).destroy
    flash[:success] = "App deleted!"
    redirect_to user_path(current_user)
  end

  private
    def app_params
      params.require(:app).permit(:name)
    end

    def fetch_app
      App.find(params[:id])
    end




end
