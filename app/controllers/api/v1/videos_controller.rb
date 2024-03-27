class Api::V1::VideosController < Api::V1::BaseController
  skip_before_action :authenticate, only: %i[create index]

  def create
    if params[:keyword].present?
      # VideoSearchService.call(keyword: params[:keyword])
      flash[:notice] = 'ビデオを正常に保存しました。'
    else
      flash[:alert] = 'キーワードを入力してください。'
    end
  end

  def index
    @video = Video.all
    render json: @video
  end

  def search
    @_current_user = current_user

    if @_current_user.searches.where('searched_at >= ?', Time.zone.now.beginning_of_day).exists?
      render json: { error: "検索は1日1回までです" }, status: :forbidden
    else
      @_current_user.searches.create(user_id: @_current_user.id, uid: @_current_user.uid, searched_at: Time.zone.now)
      address_for_video = AddressService.save_address_for_video(1, video_params[:address_components], video_params[:formatted_address])
      videos_data = VideoSearchService.call(keyword: "#{address_for_video[0]} #{address_for_video[1]} walking tour")
      search_keywords = ("#{address_for_video[0]} #{address_for_video[1]} #{address_for_video[2]} walking tour")
      render json: {videos_data: videos_data, search_keywords: search_keywords}
    end
  end

  private

  def video_params
    params.require(:video).permit(:formatted_address, address_components: [:long_name, :short_name, types: []])
  end
end
