class Api::V1::TagsController < Api::V1::ApiBaseController
  respond_to :json
  skip_before_action :authenticate, only: [:index, :show]
  before_action :offset_params, only: [:index]

  NO_PUB_ID = "Need a pub to attach tag to"
  CANT_FIND_PUB = "The pub could not find the pub"


  def index
    if (params[:pub_id])
      pub = Pub.find_by_id(params[:pub_id])
      respond_with pub.tags
    else
      respond_with Tag.all
    end
  end

  def show
    respond_with Tag.find_by_id(params[:id])
  end

  def create
    if params[:pub_id].blank?
      render json: { error: NO_PUB_ID } and return
    end

    pub = Pub.find_by_id(params[:pub_id])
    render json: { error: CANT_FIND_PUB } and return unless pub.present?

    pub = Pub.find_by_id(params[:pub_id])

    begin
      tag = Tag.new(tag_params)

      if tag.save
        pub.tags << tag
        render json: tag, status: 201, location: [:api, tag]
      else
        render json: { errors: tag.errors }, status: 402
      end
    rescue JSON::ParserError => e
      render json: { error: COULD_NOT_PARSE_JSON }, status: :bad_request
    end

  end


  private
    def tag_params
      json_params = ActionController::Parameters.new(JSON.parse(request.body.read))
      json_params.require(:tag).permit(:name)
    end

end
