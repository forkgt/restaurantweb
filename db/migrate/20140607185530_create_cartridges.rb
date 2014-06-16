class CreateCartridges < ActiveRecord::Migration
  def change
    create_table :cartridges do |t|
      t.string :name
      t.string :bei
      t.integer :rank
      t.string :image
      t.decimal :price
      t.integer :interval, default: 12

      t.timestamps
    end
  end
end
