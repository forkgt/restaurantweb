json.array!(@cart_items) do |cart_item|
  json.extract! cart_item, :name, :note, :price, :quantity, :cart_id, :cart_itemable_id
  json.url cart_item_url(cart_item, format: :json)
end
