json.array!(@subscriptions) do |subscription|
  json.extract! subscription, :store_id, :subscribable_id, :status
  json.url subscription_url(subscription, format: :json)
end
