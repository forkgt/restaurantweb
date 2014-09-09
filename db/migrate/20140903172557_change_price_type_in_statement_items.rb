class ChangePriceTypeInStatementItems < ActiveRecord::Migration
  def up
    change_column :statement_items, :price, :decimal, :default => 0, :precision => 8, :scale => 2
  end

  def down
    change_column :statement_items, :price, :decimal
  end
end
