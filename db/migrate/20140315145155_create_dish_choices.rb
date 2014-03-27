class CreateDishChoices < ActiveRecord::Migration
  def change
    create_table :dish_choices do |t|
      t.string :name
      t.string :desc
      t.string :content, :default => 'abc:0,def:1'
      t.string :input_type, :default => 'radio'
      t.boolean :must, :default => false
      t.references :store, index: true
      t.integer :checked, :default => 0

      t.timestamps
    end
  end
end
