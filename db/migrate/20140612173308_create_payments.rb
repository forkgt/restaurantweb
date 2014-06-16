class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :name
      t.integer :rank
      t.string :bei
      t.string :image
      t.string :account
      t.references :store, index: true

      t.timestamps
    end
  end
end
