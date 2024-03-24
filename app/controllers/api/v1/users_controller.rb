class Api::V1::UsersController < Api::V1::BaseController

  def index
    users = User.all
  end

  def show
    @_current_user = current_user
    user_with_relations = User.includes(:maps, :likes).find(@_current_user.id)

    if user_with_relations
      render json: user_with_relations.as_json(include: [:maps, :likes])
    else
      render json: {}, status: :not_found
    end
  end

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
