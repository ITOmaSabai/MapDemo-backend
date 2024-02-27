require 'google/apis/youtube_v3'

class VideoSearchService
  def self.call(keyword:)
    youtube_service = YoutubeService.new(api_key: ENV['GOOGLE_YOUTUBE_API_KEY'])
    @videos = youtube_service.search_videos(keyword)
  rescue Google::Apis::Error => e
    # APIからのエラーを適切に処理する
    # flash[:alert] = '動画の検索中にエラーが発生しました。'
    # redirect_to root_path
  end
end