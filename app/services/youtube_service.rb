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
        max_results: '3',
        type: 'video',
        video_embeddable: 'true',
        order: "relevance",
    )
  end
end
