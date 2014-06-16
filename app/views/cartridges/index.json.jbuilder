json.array!(@cartridges) do |cartridge|
  json.extract! cartridge, :name, :bei, :rank, :image, :price, :interval
  json.url cartridge_url(cartridge, format: :json)
end
