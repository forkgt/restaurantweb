json.array!(@dishes) do |dish|
  json.extract! dish, :name, :desc, :rank, :avatar, :price, :category_id
  json.url dish_url(dish, format: :json)
end
