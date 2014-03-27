class AddAvatarToDishFeatures < ActiveRecord::Migration
  def change
    add_column :dish_features, :avatar, :string
  end
end
