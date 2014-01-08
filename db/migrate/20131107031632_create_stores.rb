class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :desc
      t.integer :rank
      t.string :avatar
      t.string :phone
      t.string :fax
      t.decimal :delivery_minimum
      t.decimal :delivery_fee, :default => 0, :precision => 8, :scale => 2
      t.integer :delivery_radius
      t.references :admin, index: true

      t.timestamps
    end
  end
end
