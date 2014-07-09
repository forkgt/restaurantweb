class Cart < ActiveRecord::Base
  #All Attributes:
  #========================================================================
  #class CreateCarts < ActiveRecord::Migration
  #  def change
  #    create_table :carts do |t|
  #      t.string :delivery_type, :default => 'delivery', :null => false
  #      t.decimal :delivery_fee, :default => 0, :precision => 8, :scale => 2
  #      t.references :store, index: true
  #
  #      t.timestamps
  #    end
  #  end
  #end


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
    if delivery_type == 'delivery'
      subtotal_price + tax + delivery_fee
    else
      subtotal_price + tax
    end
  end

end
