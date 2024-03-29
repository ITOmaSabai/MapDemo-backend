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

  def edit
    @_current_user = current_user
  end

  def update
    @_current_user = current_user
    @_current_user.update(user_params)
  end

  def destroy
    user = User.destroy(params[:id])
  end

  def search
    @_current_user = current_user
    if @_current_user.check_search
      render json: { isSearched: true }
    else
      render json: { isSearched: false }
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :uid, :avatar)
  end
end
