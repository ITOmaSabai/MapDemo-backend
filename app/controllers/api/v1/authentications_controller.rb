class Api::V1::AuthenticationController < Api::V1::BaseController
  def create
    render json: { message: 'ログインに成功しました' } if current_user
  end
end