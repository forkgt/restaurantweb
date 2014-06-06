class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string :name
      t.string :bei
      t.integer :rank
      t.string :image
      t.decimal :price, :precision => 8, :scale => 2
      t.references :category, index: true

      t.timestamps
    end
  end
end
