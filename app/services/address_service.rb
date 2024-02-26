class AddressService
  def self.save_address_from_address_components(map_id, address_components)
    country = extract_long_name_by_type(address_components, 'country')
    administrative_area_level_1 = extract_long_name_by_type(address_components, 'administrative_area_level_1')

    address = Address.create(
      map_id: map_id,
      country: country,
      administrative_area_level_1: administrative_area_level_1,
      formatted_address: "#{address_components.formatted_address}"
    )
    return address
  end

  private

  def self.extract_long_name_by_type(address_components, type)
    component = address_components.find { |component| component['types'].include?(type) }
    component ? component['long_name'] : nil
  end
end