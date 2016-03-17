class Api::V1::CreatorsController < Api::V1::ApiBaseController
  skip_before_action :authenticate, only: [:index, :show]
  before_action :offset_params, only: [:index]
  def index
    respond_with Creator.limit(@limit).offset(@offset)
  end

  def show
    respond_with Creator.find(params[:id])
  end
end
