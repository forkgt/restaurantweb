class Dish < ActiveRecord::Base
  #All Attributes:
  #========================================================================
  #class CreateDishes < ActiveRecord::Migration
  #  def change
  #    create_table :dishes do |t|
  #      t.string :name
  #      t.string :bei
  #      t.integer :rank
  #      t.string :image
  #      t.decimal :price, :precision => 8, :scale => 2
  #      t.references :category, index: true
  #
  #      t.timestamps
  #    end
  #  end
  #end



  belongs_to :category

  has_and_belongs_to_many :dish_features
  has_and_belongs_to_many :dish_choices

  mount_uploader :image, PhotoUploader
end
