class CreateDishFeatures < ActiveRecord::Migration
  def change
    create_table :dish_features do |t|
      t.string :name
      t.string :bei
      t.integer :rank
      t.string :image
      t.references :store, index: true

      t.timestamps
    end
  end
end
