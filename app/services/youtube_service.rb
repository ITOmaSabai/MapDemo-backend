require 'google/apis/youtube_v3'

class YoutubeService
  def initialize(api_key:)
    @youtube = Google::Apis::YoutubeV3::YouTubeService.new
    @youtube.key = api_key
  end

  def search_videos(keyword)
    @youtube.list_searches(
        'snippet',
        q: "#{keyword}",
        # location: "#{lat},#{lng}",
        max_results: '10',
        # order: 'viewCount',
        type: 'video',
        # videoEmbeddable: 'true'
        # fields: 'items(id,snippet(title,channel_title,thumbnails))'
    )
  end
end
