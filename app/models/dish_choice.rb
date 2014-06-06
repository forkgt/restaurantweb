class DishChoice < ActiveRecord::Base
  #All Attributes:
  #========================================================================
  #class CreateDishChoices < ActiveRecord::Migration
  #  def change
  #    create_table :dish_choices do |t|
  #      t.string :name
  #      t.string :bei
  #      t.string :content, :default => 'abc:0,def:1'
  #      t.string :input_type, :default => 'radio'
  #      t.boolean :must, :default => false
  #      t.references :store, index: true
  #      t.integer :checked, :default => 0
  #
  #      t.timestamps
  #    end
  #  end
  #end


  belongs_to :store

  has_and_belongs_to_many :dishes
end
