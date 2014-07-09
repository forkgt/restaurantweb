class CreateDeliveryRules < ActiveRecord::Migration
  def change
    create_table :delivery_rules do |t|
      t.string :name
      t.string :bei
      t.integer :rank
      t.decimal :delivery_fee, :default => 0, :precision => 8, :scale => 2
      t.decimal :delivery_minimum, :default => 0, :precision => 8, :scale => 2
      t.float :delivery_radius
      t.references :store, index: true

      t.timestamps
    end
  end
end
