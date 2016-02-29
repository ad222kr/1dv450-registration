class Api::V1::PubsController < ApplicationController

  before_action :authenticate
  before_action :restrict_access
  respond_to :json

  def index
    respond_with Pubs.all
  end


  def show
    respond_with Pub.find(params[:id])
  end

  def create
    pub = Pub.new(pub_params)
    pub.creator = current_user
    if pub.save
      render json: pub, status: 201, location: [:api, pub]
    else
      render json: { errors: pub.errors }, status: 422
    end
  end

  def update
    pub = Pub.find(params[:id])
    if pub.update(pub_params)
      render json: pub, status: 200, location: [:api, pub]
    else

    end
  end

  def destroy
    pub = Pub.find(params[:id])
    pub.destroy
    head 204
  end

  private
    def pub_params
      params.require(:pub).permit(:name, :phone_number, :description)
    end

    def restrict_access
      # Cannot send multiple Authorization-headers. Knock uses for end-user
      # authorization so the API-key is sent via a custom header instead
      api_key = request.headers['X-Api-Key']
      @app = App.where(api_key: api_key).first if api_key
      unless @app
        render json: { errors: { developer_error: "The API-key is invalid", user_error: "Something went wrong" } }, status: :unauthorized
      end
    end

end
