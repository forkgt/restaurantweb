class ChangePriceTypeInCartridges < ActiveRecord::Migration
  def up
    change_column :cartridges, :price, :decimal, :default => 0, :precision => 8, :scale => 2
  end

  def down
    change_column :cartridges, :price, :decimal
  end
end
