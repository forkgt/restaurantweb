class CreateDishChoicesDishesJoinTable < ActiveRecord::Migration
  def change
    create_join_table :dish_choices, :dishes do |t|
      t.index [:dish_choice_id, :dish_id]
      t.index [:dish_id, :dish_choice_id]
    end
  end
end
