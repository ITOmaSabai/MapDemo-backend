class LikesController < ApplicationController
  def create
    like = Like.new(like_params)
    if like.save
      render json: like, status: :created
    else
    end
  end

  def destroy
    Like.destroy(params[:id])
    head :no_content
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :map_id)
  end
end
