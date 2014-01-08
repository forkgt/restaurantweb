class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :name
      t.string :desc
      t.integer :rank
      t.string :avatar
      t.references :store, index: true

      t.timestamps
    end
  end
end
