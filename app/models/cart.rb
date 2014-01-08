class Cart < ActiveRecord::Base
  belongs_to :store

  has_many :orders
  has_many :cart_items, dependent: :destroy

  def subtotal_price
    cart_items.to_a.sum { |item| item.total_price }
  end

  def tax
    subtotal_price * 0.0825
  end

  def total_price
    subtotal_price + tax + delivery_fee
  end

  def add_dish(dish, name, price, quantity, note)
    current_item = cart_items.find_by_cart_itemable_id_and_cart_itemable_type_and_note(dish.id, dish.class.to_s, note)
    if current_item
      current_item.quantity += quantity
    else
      current_item = cart_items.build(cart_itemable: dish, name: name, price: price, quantity: quantity, note: note)
    end
    current_item
  end

  def add_coupon(coupon, name, price, quantity)
    current_item = cart_items.find_by_cart_itemable_id_and_cart_itemable_type(coupon.id, coupon.class.to_s)
    unless current_item
      current_item = cart_items.build(cart_itemable: coupon, name: name, price: price, quantity: quantity)
    end
    current_item
  end

end