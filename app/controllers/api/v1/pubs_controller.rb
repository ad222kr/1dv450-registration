class Api::V1::PubsController < Api::V1::ApiBaseController
  skip_before_action :authenticate, only: [:index, :show]
  before_action :offset_params, only: [:index]
  respond_to :json

  LOCATION_TAKEN     = "There already exists a pub at that location. Cant have two pubs at the same location eh?"
  CANT_EDIT          = "You did not create the post and cannot edit it"
  CANT_DESTROY       = "You did not create the post and cannot delete it"
  CAND_FIND_PUB      = "Could not find a pub with that id"
  PUB_NEEDS_POSITION = "The pub needs aposition!"
  DEFAULT_DISTANCE   = 10

  def get_pubs_near_positions(position_params)
    pubs = []
    10.times { puts position_params }
    distance = params[:distance] ? params[:distance] : DEFAULT_DISTANCE
    positions = Position.near(position_params, distance, :units => :km)

    positions.each do |p|
      pubs << p.pub
    end
    pubs
  end

  def index
    if params[:tag_id]
      # Get pubs connected to a tag
      tag = Tag.find_by_id(params[:tag_id])
      if tag
        pubs = tag.pubs.limit(@limit).offset(@offset)
      end
    elsif params[:creator_id]
      # Get pubs connected to a creator
      creator = Creator.find_by_id(params[:creator_id])

      if creator
        pubs = creator.pubs.limit(@limit).offset(@offset)

      end
    elsif params[:near_address]
    # Query params starts here
      # Search for pubs near a position (address)
      # positions = Position.near(params[:near_address], params[:distance] ? params[:distance] : DEFAULT_DISTANCE, :units => :km)
      # positions.each do |p|
      #   pubs << p.pub
      # end
      pubs = get_pubs_near_positions(params[:near_address])
    elsif params[:lng] && params[:ltd]
      # Search for pubs near a position (longitude and latitude)
      # pubs = []
      # positions = Position.near([params[:ltd], params[:lng]], params[:distance] ? params[:distance] : DEFAULT_DISTANCE, :units => :km)
      # positions.each do |p|
      #   pubs << p.pub
      # end
      pubs = get_pubs_near_positions([params[:ltd], params[:lng]])
    else
      pubs = Pub.all
    end

    if pubs.present?
      # starts_with query can be present
      pubs = pubs.starts_with(params[:starts_with]) if params[:starts_with]
      response = { offset: @offset, limit: @limit, count: pubs.count, pubs: ActiveModel::ArraySerializer.new(pubs) }
      respond_with response
    else
      render json: { error: "Could not find any pubs" }, status: :not_found
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
        respond_with pub, status: 201, location: [:api, pub]
        # render json: pub, status: 201, location: [:api, pub]
      else
        render json: { errors: pub.errors.messages }, status: 402
      end
    rescue JSON::ParserError => e
      render json: { error: COULD_NOT_PARSE_JSON }, status: :bad_request
    end
  end

  def update
    pub = Pub.find_by_id(params[:id])

    render json: { error: CAND_FIND_PUB }, status: :bad_request and return unless pub
    render json: { error: CANT_EDIT }, status: :unauthorized and return unless current_user == pub.creator



    begin
      if pub.update(pub_params)
        render json: { action: "update", pub: PubSerializer.new(pub) }, status: :ok
      else
        render json: { errors: pub.errors.messages }, status: :bad_request
      end
    rescue JSON::ParserError => e
      render json: { error: COULD_NOT_PARSE_JSON }, status: :bad_request
    end
  end

  def destroy
    10.times { puts current_user.id }
    pub = Pub.find_by_id(params[:id])

    render json: { error: CAND_FIND_PUB }, status: :bad_request and return unless pub
    render json: { error: CANT_DESTROY }, status: :bad_request and return unless current_user == pub.creator

    pub.destroy
    render json: { action: "destroy", message: "Pub with id #{params[:id]} was removed" }, status: :ok

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
