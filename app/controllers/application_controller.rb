require './app/controllers/concerns/firebase_authenticator.rb'
require 'jwt'
require 'net/http'

class ApplicationController < ActionController::API
  include FirebaseAuthenticator
  before_action :authenticate
  class AuthenticationError < StandardError; end
  rescue_from AuthenticationError, with: :not_authenticated

  def authenticate
    auth_header = request.headers["Authorization"]&.split&.last
    # TokenValidatorのvalidateメソッドを呼び出し、リクエストヘッダーのペイロードを取得する
    payload = validate(auth_header)

    # 取得したトークンの情報を持っているユーザーが存在するか確認する。
    # 確認方法は、User.findする
    if payload
      user = verify_user(payload["user_id"])

      if user
        puts(user)
      else
        user_info = { name: payload["user_id"], uid: payload["user_id"], avatar: payload["picture"] }
      # (登録済みユーザー)が存在しない場合は、users#createを実行する。その際のパラメーターは(token)から取得した値とする
        user = User.create(name: "Masahiro Ito", uid: "JlteXb9x99VZCg9seMVHdIv3izI3", avatar: "https://lh3.googleusercontent.com/a/ACg8ocIumpEWgAf5w2RBYH9kufOOg4IGOfUjenXQ5-vja6QFMw=s96-c"    )
      end
    end

    # ペイロードのuser_idをcurrent_userメソッドに渡し、値が返ってこなければエラーを発生させる
    # raise AuthenticationError unless current_user(payload["user_id"])
  end

  def current_user(user_id = nil)
    # uidがuser_idと等しいユーザーを探して@current_userに代入する(@current_userがnilまたはfalseの場合)
    @current_user ||= User.find_by(uid: user_id)
  end

  def verify_user(user_id)
    # user_idをuidに持つユーザーが登録済みなら、current_userに代入する
    user = User.find_by(uid: user_id)
  end

  private
  def not_authenticated
    render json: { error: { messages: ["ログインしてください"] } }, status: :unauthorized
  end
  
end
