json.array!(@addresses) do |address|
  json.extract! address, :address1, :address2, :city, :state, :country, :zip, :latitude, :longitude, :gmaps, :addressable_id
  json.url address_url(address, format: :json)
end
