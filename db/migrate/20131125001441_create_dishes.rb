class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string :name
      t.string :desc
      t.integer :rank
      t.string :avatar
      t.decimal :price, :precision => 8, :scale => 2
      t.references :category, index: true

      t.timestamps
    end
  end
end
