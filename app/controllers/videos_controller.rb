class VideosController < ApplicationController
  def create
    if params[:keyword].present?
      VideoSearchService.call(keyword: params[:keyword])
      flash[:notice] = 'ビデオを正常に保存しました。'
    else
      flash[:alert] = 'キーワードを入力してください。'
    end
    redirect_to videos_path # 適切なパスにリダイレクト
  end

  def show
    @video = Video.find(map_id: params[:id])
  end
end
