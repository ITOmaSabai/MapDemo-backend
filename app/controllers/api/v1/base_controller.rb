require './app/controllers/concerns/firebase_authenticator'

class Api::V1::BaseController < ApplicationController
  include FirebaseAuthenticator
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate

  def authenticate
    authenticate_with_http_token do |token, _options|
      result = verify_id_token(token)
      p result

      if result[:errors]
        render json: {message: "400"}
      else
        @_current_user = User.find_or_create_user(result)
      end
    end
  end

  def current_user
    @_current_user
  end
end
