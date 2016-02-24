class Api::V1::PubsController < ApplicationController
  protect_from_forgery with: :null_session
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

  private
    def pub_params
      params.require(:pub).permit(:name, :phone_number, :description)
    end

end
