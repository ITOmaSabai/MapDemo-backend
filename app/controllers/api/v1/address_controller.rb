class Api::V1::AddressController < ApplicationController
  def index
    @addresses = Address.all
    render json: @addresses
end