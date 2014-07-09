json.array!(@delivery_rules) do |delivery_rule|
  json.extract! delivery_rule, :id, :name, :bei, :rank, :delivery_fee, :delivery_minimum, :delivery_radius, :store_id
  json.url delivery_rule_url(delivery_rule, format: :json)
end
