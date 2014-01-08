class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.string :name
      t.string :note
      t.decimal :price, :precision => 8, :scale => 2
      t.integer :quantity, :default => 1
      t.references :cart, index: true
      t.references :cart_itemable, index: true, :polymorphic => true

      t.timestamps
    end
  end
end
