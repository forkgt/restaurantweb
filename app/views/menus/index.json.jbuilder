json.array!(@menus) do |menu|
  json.extract! menu, :name, :desc, :rank, :avatar, :store_id
  json.url menu_url(menu, format: :json)
end
