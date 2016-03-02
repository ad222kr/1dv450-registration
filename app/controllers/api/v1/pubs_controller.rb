class Api::V1::PubsController < Api::V1::ApiBaseController

  skip_before_action :authenticate, only: [:index, :show]
  before_action :restrict_access
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

    def restrict_access
      # Cannot send multiple Authorization-headers. Knock uses for end-user
      # authorization so the API-key is sent via a custom header instead
      api_key = request.headers['Api-Key']
      @app = App.where(api_key: api_key).first if api_key
      unless @app
        render json: { errors: { developer_error: "The API-key is invalid", user_error: "Something went wrong" } }, status: :unauthorized
      end
    end

end
