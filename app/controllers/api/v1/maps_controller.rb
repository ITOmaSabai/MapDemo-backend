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
    map = Map.new(map_params.except(:addressComponents))
    if map.save
      AddressService.save_address_from_address_components(map, map_params[:addressComponents])
      render json: map, status: :created
    else
      render json: map.errors, status: :unprocessable_entity
    end
  end

  private

  def map_params
    params.require(:map).permit(:name, :description, :lat, :lng, addressComponents: [])
  end
end