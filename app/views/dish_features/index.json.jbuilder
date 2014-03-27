json.array!(@dish_features) do |dish_feature|
  json.extract! dish_feature, :name, :desc, :rank, :store_id
  json.url dish_feature_url(dish_feature, format: :json)
end
