class Api::V1::ApiBaseController < ApplicationController
  include Knock::Authenticable
  protect_from_forgery with: :null_session
  before_action :authenticate

end
