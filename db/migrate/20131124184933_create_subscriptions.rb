class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :store, index: true
      t.references :subscribable, index: true, polymorphic: true
      t.string :status

      t.timestamps
    end
  end
end
