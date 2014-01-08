json.array!(@templates) do |template|
  json.extract! template, :name, :desc, :rank, :avatar, :price, :interval
  json.url template_url(template, format: :json)
end
