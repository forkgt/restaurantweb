json.array!(@statement_items) do |statement_item|
  json.extract! statement_item, :day, :name, :note, :price, :quantity, :statement_id
  json.url statement_item_url(statement_item, format: :json)
end
