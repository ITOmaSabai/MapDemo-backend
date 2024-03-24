class Api::V1::LikesController < Api::V1::BaseController

  skip_before_action :authenticate, only: [:index]

  def index
    likes = Like.where(map_id: params[:map_id])
    render json: likes
  end

  def create
    @_current_user = current_user

    like = @_current_user.likes.new(like_params)
    if like.save
      render json: like, status: :created
    else
    end
  end

  def destroy
    @_current_user = current_user

    like = @_current_user.likes.find_by(id: params[:id])
    like&.destroy
    head :no_content
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :map_id)
  end
end
