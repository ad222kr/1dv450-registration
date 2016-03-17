class Api::V1::PubsController < Api::V1::ApiBaseController
  skip_before_action :authenticate, only: [:index, :show]
  before_action :offset_params, only: [:index]
  respond_to :json

  LOCATION_TAKEN     = "There already exists a pub at that location. Cant have two pubs at the same location eh?"
  CANT_EDIT          = "You did not create the post and cannot edit it"
  CAND_FIND_PUB      = "Could not find a pub with that id"
  PUB_NEEDS_POSITION = "The pub needs aposition!"

  def index
    if params[:tag_id]
      tag = Tag.find_by(id: params[:tag_id])
      if tag
        respond_with tag.pubs.limit(@limit).offset(@offset)
      else
        render json: {
          developer_error: "Could not find a tag with that id, therefore no pubs exist",
          user_error: "Something went wrong when getting pubs"
        }, status: :not_found
        return
      end
    elsif params[:creator_id]
      creator = Creator.find_by(id: params[:creator_id])
      if creator
        respond_with cretor.pubs.limit(@limit).offset(@offset)
      else

      end
    else
      respond_with Pub.limit(@limit).offset(@offset)
    end
  end

  def show
    pub = Pub.find(params[:id])
    respond_with pub, status: :ok
  end

  def create
    begin
      return unless position_param_present? && position_is_available?

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
    rescue JSON::ParserError => e
      render json: {
        developer_error: "Could not parse json",
        user_error: "Something went wrong"
      }, status: :bad_request
    end
  end

  def update
    pub = Pub.find_by_id(params[:id])

    render json: {
      error: CANT_EDIT
    } and return unless current_user == pub.creator
    render json: { error: CAND_FIND_PUB } and return unless pub

    begin
      if pub.update(pub_params)
        render json: { action: "update", pub: PubSerializer.new(pub) }, status: :ok
      else
        render json: { errors: pub.errors.messages }, status: :bad_request
      end
    rescue JSON::ParserError => e
      render json: {
        developer_error: "Could not parse json",
        user_error: "Something went wrong"
      }, status: :bad_request
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


    def position_param_present?
      if pub_params[:position].blank?
        render json: { errors: PUB_NEEDS_POSITION }
        return false
      end
      return true
    end

    def position_is_available?
      if Position.find_by_address(pub_params[:position][:address])
        render json: { errors: LOCATION_TAKEN }, status: :conflict
        return false
      end
      return true
    end
end
