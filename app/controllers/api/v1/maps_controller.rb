class Api::V1::MapsController < ApplicationController
  def index
    @maps = Map.where.not(lat: nil, lng: nil)
    render json: @maps
  end

  def show
    @map = Map.includes(:videos).find(params[:id])
    @videos = @map.videos
  end

  def create
    map = Map.new(map_params.except(:address_components, :formatted_addres))
    if map.save
      address = AddressService.save_address_from_address_components(map.id, map_params[:address_components], map_params[:formatted_addres])
      address_for_video = AddressService.save_address_for_video(map.id, map_params[:address_components], map_params[:formatted_addres])
      video = VideoSearchService.call(keyword: "#{address_for_video[0]}, #{address_for_video[1]}")
      render json: { map: map, address: address, video: video }, status: :created
    else
      render json: map.errors, status: :unprocessable_entity
    end
  end

  private

  def map_params
    params.require(:map).permit(:name, :description, :lat, :lng, :formatted_addres, address_components: [:long_name, :short_name, types: []])
  end
end