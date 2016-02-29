class Api::V1::PubsController < ApplicationController

  before_action :authenticate
  # before_action :restrict_access
  respond_to :json

  def index
    respond_with Pubs.all
  end


  def show
    respond_with Pub.find(params[:id])
  end

  def create
    pub = Pub.new(pub_params)
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
      rebder
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
#
    def restrict_access
      authenticate_or_request_with_http_token do |token, options|
        App.exists?(api_key: token)
      end
    end

end
