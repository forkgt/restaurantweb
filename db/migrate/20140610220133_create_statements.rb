class CreateStatements < ActiveRecord::Migration
  def change
    create_table :statements do |t|
      t.integer :year
      t.integer :month
      t.string :payment_type
      t.string :payment_status
      t.string :invoice
      t.references :store, index: true

      t.timestamps
    end
  end
end
