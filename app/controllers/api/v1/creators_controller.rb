class Api::V1::CreatorsController < Api::V1::ApiBaseController
  skip_before_action :authenticate, only: [:index, :show]
  def index
    respond_with Creator.all
  end

  def show
    respond_with Creator.find(params[:id])
  end
end
