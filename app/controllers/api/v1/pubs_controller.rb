class Api::V1::PubsController < Api::V1::ApiBaseController


  skip_before_action :authenticate, only: [:index, :show]

  respond_to :json

  def index
    respond_with Pub.all
  end


  def show
    pub = Pub.find(params[:id])
    respond_with pub, status: :ok
  end



  def create
    return unless pub_has_position? && position_is_available?

    pub = Pub.new(pub_params.except(:tags, :position))
    pub.creator = current_user
    pub.position = Position.create(pub_params[:position])

    if tags = pub_params[:tags]
      tags.each do |tag|
        pub.tags << Tag.where(tag).first_or_create
      end
    end

    if pub.save
      render json: pub, status: 201, location: [:api, pub]
    else
      render json: { errors: pub.errors.messages }, status: 402
    end
  end


  def update
    pub = Pub.find_by_id(params[:id])
    render json: { error: "You did not create the post and cannot edit it" } and return unless current_user == pub.creator

    render json: { error: "Could not find a pub with that id"} unless pub


    if pub.update(pub_params)
      render json: { action: "update", pub: PubSerializer.new(pub) }, status: :ok
    else
      render json: { errors: pub.errors.messages }, status: :bad_request
    end
  end

  def destroy
    pub = Pub.find(params[:id])
    pub.destroy
    head 204
  end

  private
    def pub_params
      json_params = ActionController::Parameters.new(JSON.parse(request.body.read))
      json_params.require(:pub).permit(:name, :phone_number, :description, tags: [:name], position: [:address])
    end

    def pub_has_position?
      if pub_params[:position].blank?
        render json: { errors: "The pub needs aposition!" }
        return false
      end
      return true
    end

    def position_is_available?
      if Position.find_by_address(pub_params[:position][:address])
        render json: { errors: "There already exists a pub at that location. Cant have two pubs at the same location eh?" }, status: :conflict
        return false
      end
      return true
    end
end
