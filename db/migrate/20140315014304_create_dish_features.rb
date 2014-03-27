class CreateDishFeatures < ActiveRecord::Migration
  def change
    create_table :dish_features do |t|
      t.string :name
      t.string :desc
      t.integer :rank
      t.references :store, index: true

      t.timestamps
    end
  end
end
