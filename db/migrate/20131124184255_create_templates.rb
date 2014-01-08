class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :name
      t.string :desc
      t.integer :rank
      t.string :avatar
      t.decimal :price , precision: 8, scale: 2
      t.integer :interval, default: 12

      t.timestamps
    end
  end
end
