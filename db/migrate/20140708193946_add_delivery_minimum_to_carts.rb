class AddDeliveryMinimumToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :delivery_minimum, :decimal, :default => 0, :precision => 8, :scale => 2
  end
end
