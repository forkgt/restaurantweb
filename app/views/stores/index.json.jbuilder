json.array!(@stores) do |store|
  json.extract! store, :name, :bei, :rank, :image, :phone, :fax, :delivery_minimum, :delivery_fee, :delivery_radius, :admin_id
  json.url store_url(store, format: :json)
end
