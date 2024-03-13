class Api::V1::UsersController < ApplicationController
  def create
    user = User.create(user_params)

    if user.save!
      render json: user
    else
      render json: user.error
    end
  end

  def destroy
    user = User.destroy(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :uid, :avatar)
  end
end
