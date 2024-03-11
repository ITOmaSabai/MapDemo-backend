class Api::V1::VideosController < ApplicationController
  def create
    if params[:keyword].present?
      # VideoSearchService.call(keyword: params[:keyword])
      flash[:notice] = 'ビデオを正常に保存しました。'
    else
      flash[:alert] = 'キーワードを入力してください。'
    end
    redirect_to videos_path # 適切なパスにリダイレクト
  end

  def index
    @video = Video.all
    render json: @video
  end

  def search
    address_for_video = AddressService.save_address_for_video(1, video_params[:address_components], video_params[:formatted_address])
    videos_data = VideoSearchService.call(keyword: "#{address_for_video[0]} #{address_for_video[1]} walking tour")
    search_keywords = ("#{address_for_video[0]} #{address_for_video[1]} #{address_for_video[2]} walking tour")
    render json: {videos_data: videos_data, search_keywords: search_keywords}
  end

  private

  def video_params
    params.require(:video).permit(:formatted_address, address_components: [:long_name, :short_name, types: []])
  end
end
