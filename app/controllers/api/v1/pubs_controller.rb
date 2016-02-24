class Api::V1::PubsController < ApplicationController
  respond_to :json

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

  private
    def pub_params
      params.require(:pub).permit(:name, :phone_number, :description)
    end

end
