class Api::V1::TagsController < Api::V1::ApiBaseController
  skip_before_action :authenticate, only: [:index, :show]

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

  private
    def tag_params

    end

end
