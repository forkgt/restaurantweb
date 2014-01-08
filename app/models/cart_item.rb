class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :cart_itemable, :polymorphic => true

  def total_price
    price * quantity
  end
end
