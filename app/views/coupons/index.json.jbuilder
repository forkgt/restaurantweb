json.array!(@coupons) do |coupon|
  json.extract! coupon, :name, :desc, :rank, :avatar, :price, :minimum, :start_at, :end_at, :store_id
  json.url coupon_url(coupon, format: :json)
end
