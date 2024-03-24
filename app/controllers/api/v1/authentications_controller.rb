class Api::V1::AuthenticationsController < Api::V1::BaseController
  def create
    render json: { message: 'ログインに成功しました', user: current_user.as_json } if current_user
  end
end