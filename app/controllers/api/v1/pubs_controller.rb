class Api::V1::PubsController < Api::V1::ApiBaseController

  skip_before_action :authenticate, only: [:index, :show]

  respond_to :json

  def index
    respond_with Pub.all
  end


  def show
    @pub = Pub.find(params[:id])
    respond_with @pub, status: :ok
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



end
