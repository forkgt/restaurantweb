json.array!(@dish_choices) do |dish_choice|
  json.extract! dish_choice, :name, :desc, :content, :input_type, :must, :store_id, :checked
  json.url dish_choice_url(dish_choice, format: :json)
end
