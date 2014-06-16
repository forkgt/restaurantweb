json.array!(@statements) do |statement|
  json.extract! statement, :year, :month, :payment_type, :payment_status, :invoice, :store_id
  json.url statement_url(statement, format: :json)
end
