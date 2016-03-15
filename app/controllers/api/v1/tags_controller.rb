class Api::V1::TagsController < Api::V1::ApiBaseController
  respond_to :json
  skip_before_action :authenticate, only: [:index, :show]
  CANT_FIND_PUB = "The pub to add the tag to could not be found or was not specified"

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
      render json: { error: "Need a pub to attach tag to" } and return
    end

    pub = Pub.find_by_id(params[:pub_id])
    render json: { error: "Could not find the pub" } and return unless pub.present?

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
      render json: { developer_error: "Could not parse json", user_error: "Something went wrong" }, status: :bad_request
    end

  end


  private
    def tag_params
      json_params = ActionController::Parameters.new(JSON.parse(request.body.read))
      json_params.require(:tag).permit(:name)
    end

end
