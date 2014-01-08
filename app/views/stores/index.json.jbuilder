json.array!(@stores) do |store|
  json.extract! store, :name, :desc, :rank, :avatar, :phone, :fax, :delivery_minimum, :delivery_fee, :delivery_radius, :admin_id
  json.url store_url(store, format: :json)
end
