class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :country
      t.string :zip
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps
      t.references :addressable, index: true, :polymorphic => true

      t.timestamps
    end
  end
end
