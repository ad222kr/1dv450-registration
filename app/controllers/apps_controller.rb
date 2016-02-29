class AppsController < ApplicationController
  before_action :check_if_logged_in, only: [:new, :destroy, :create]
  def new
    @app = App.new
    @user = current_dev_user
  end

  def create

    # @app = App.create(app_params)
    # @app.user = current_dev_user
    @app = current_dev_user.apps.build(app_params)

    if @app.save
      flash[:success] ="Application registered!"
      redirect_to user_path(@app.user)
    else
      render 'new'
    end

  end

  def destroy
    App.find(params[:id]).destroy
    flash[:success] = "App deleted!"
    redirect_to user_path(current_dev_user)
  end

  private
    def app_params
      params.require(:app).permit(:name)
    end
end
