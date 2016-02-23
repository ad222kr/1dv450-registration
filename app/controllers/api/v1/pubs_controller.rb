class Api::V1::PubsController < ApplicationController
  respond_to :json

  def show
    respond_with Pub.find(params[:id])
  end

end
