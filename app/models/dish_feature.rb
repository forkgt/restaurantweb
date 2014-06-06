class DishFeature < ActiveRecord::Base
  #All Attributes:
  #========================================================================
  #class CreateDishFeatures < ActiveRecord::Migration
  #  def change
  #    create_table :dish_features do |t|
  #      t.string :name
  #      t.string :bei
  #      t.integer :rank
  #      t.string :image
  #      t.references :store, index: true
  #
  #      t.timestamps
  #    end
  #  end
  #end


  belongs_to :store

  has_and_belongs_to_many :dishes

  mount_uploader :image, AvatarUploader
end
