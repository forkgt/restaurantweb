json.array!(@carts) do |cart|
  json.extract! cart, :delivery_type, :delivery_fee, :store_id
  json.url cart_url(cart, format: :json)
end
