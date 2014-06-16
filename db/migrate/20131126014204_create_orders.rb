class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :note
      t.string :invoice
      t.string :payment_type, :default => 'cash', :null => false
      t.string :payment_status, :default => 'not_paid', :null => false
      t.string :transfer_status
      t.decimal :tip, :default => 0, :precision => 8, :scale => 2
      t.references :store, index: true
      t.references :cart, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
