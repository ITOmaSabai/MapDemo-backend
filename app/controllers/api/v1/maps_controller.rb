class Api::V1::MapsController < Api::V1::BaseController

  skip_before_action :authenticate, only: [:index]

  def index
    @maps = Map.includes(:user, :address, :likes, :videos).where.not(lat: nil, lng: nil)
    render json: @maps, include: [:user, :address, :likes, :videos]
  end

  def create
    @_current_user = current_user
    map = @_current_user.maps.new(map_params.except(:address_components, :formatted_address))
    map.uid = @_current_user.uid
    if map.save
      address = AddressService.save_address_from_address_components(map.id, map_params[:address_components], map_params[:formatted_address])
      address_for_video = AddressService.save_address_for_video(map.id, map_params[:address_components], map_params[:formatted_address])
      videos_data = VideoSearchService.call(keyword: "#{address_for_video[0]} #{address_for_video[1]} walking tour")

      videos_data.items.each do |video_data|
        map.videos.create(
          youtube_video_id: video_data.id.video_id,
          thumbnail_url: video_data.snippet.thumbnails.high.url
        )
      end

      render json: { map: map, address: address, videos_data: videos_data }, status: :created
    else
      render json: map.errors, status: :unprocessable_entity
    end
  end

  def destroy
    map = Map.find(params[:id])
    if map.destroy
      render json: {}, status: :no_content
    else
      render json: { error: "削除に失敗しました" }, status: :unprocessable_entity
    end
  end

  private

  def map_params
    params.require(:map).permit(:name, :description, :lat, :lng, :formatted_address, :user_id, :uid, address_components: [:long_name, :short_name, types: []])
  end
end