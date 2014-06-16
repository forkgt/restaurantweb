json.array!(@payments) do |payment|
  json.extract! payment, :name, :rank, :bei, :image, :account
  json.url payment_url(payment, format: :json)
end
