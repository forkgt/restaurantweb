json.array!(@orders) do |order|
  json.extract! order, :note, :payment_type, :payment_status, :tip, :store_id, :cart_id, :user_id
  json.url order_url(order, format: :json)
end
