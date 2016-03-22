class Api::V1::ApiBaseController < ApplicationController
  include Knock::Authenticable
  protect_from_forgery with: :null_session
  before_action :authenticate
  # before_action :restrict_access
  respond_to :json

  COULD_NOT_PARSE_JSON = "Could not parse json"

  OFFSET = 0
  LIMIT = 10

  private
    def restrict_access
      # Cannot send multiple Authorization-headers. Knock uses for end-user
      # authorization so the API-key is sent via a custom header instead
      api_key = request.headers['Api-Key']
      @app = App.where(api_key: api_key).first if api_key
      unless @app
        render json: { errors: { developer_error: "The API-key is invalid", user_error: "Something went wrong" } }, status: :unauthorized
      end
    end

    def offset_params
      if params[:offset].present?
        @offset = params[:offset]
      end
      if params[:limit].present?
        @limit = params[:limit]
      end
      @offset ||= OFFSET
      @limit ||= LIMIT
    end

end
