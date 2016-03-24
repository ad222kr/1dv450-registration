class Api::V1::ApiBaseController < ApplicationController
  include Knock::Authenticable
  protect_from_forgery with: :null_session
  before_action :authenticate
  before_action :restrict_access
  respond_to :json

  COULD_NOT_PARSE_JSON = "Could not parse json"
  API_KEY_INVALID = "API-key invalid"

  OFFSET = 0
  LIMIT = 10

  private
    # Checks if the API-key is correct. Called before every action
    def restrict_access
      api_key = request.headers['Api-Key']
      @app = App.where(api_key: api_key).first if api_key
      unless @app
        render json: { error: API_KEY_INVALID}, status: :unauthorized
      end
    end

    # Checks wheter offset and limit is present in the API-call
    def offset_params
      @offset = params[:offset] if params[:offset].present?
      @limit = params[:limit] if params[:limit].present?

      @offset ||= OFFSET
      @limit ||= LIMIT
    end

end
