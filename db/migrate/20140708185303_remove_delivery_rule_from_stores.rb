class RemoveDeliveryRuleFromStores < ActiveRecord::Migration
  def up
    remove_column :stores, :delivery_fee, :decimal
    remove_column :stores, :delivery_minimum, :decimal
    remove_column :stores, :delivery_radius, :integer
  end

  def down
    add_column :stores, :delivery_fee, :decimal, :default => 0, :precision => 8, :scale => 2
    add_column :stores, :delivery_minimum, :decimal, :default => 0, :precision => 8, :scale => 2
    add_column :stores, :delivery_radius, :integer
  end
end
