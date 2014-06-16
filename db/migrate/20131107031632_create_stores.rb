class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :bei
      t.integer :rank
      t.string :image
      t.string :domain
      t.string :phone
      t.string :fax
      t.string :status, default: "normal"
      t.string :uuid
      t.decimal :delivery_minimum, :default => 0, :precision => 8, :scale => 2
      t.decimal :delivery_fee, :default => 0, :precision => 8, :scale => 2
      t.integer :delivery_radius

      t.references :admin, index: true

      t.timestamps
    end
  end
end
