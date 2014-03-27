class CreateDishFeaturesDishesJoinTable < ActiveRecord::Migration
  def change
    create_join_table :dish_features, :dishes do |t|
      t.index [:dish_feature_id, :dish_id]
      t.index [:dish_id, :dish_feature_id]
    end
  end
end
