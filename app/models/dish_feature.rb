class DishFeature < ActiveRecord::Base
  #All Attributes:
  #========================================================================
  #class CreateDishFeatures < ActiveRecord::Migration
  #  def change
  #    create_table :dish_features do |t|
  #      t.string :name
  #      t.string :desc
  #      t.integer :rank
  #      t.references :store, index: true
  #
  #      t.timestamps
  #    end
  #  end
  #end
  #
  #class AddAvatarToDishFeatures < ActiveRecord::Migration
  #  def change
  #    add_column :dish_features, :avatar, :string
  #  end
  #end

  belongs_to :store

  has_and_belongs_to_many :dishes

  mount_uploader :avatar, AvatarUploader
end
