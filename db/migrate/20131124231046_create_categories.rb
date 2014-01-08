class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :desc
      t.integer :rank
      t.string :avatar
      t.references :menu, index: true

      t.timestamps
    end
  end
end
