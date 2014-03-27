class AddTransferStatusToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :transfer_status, :string
  end
end
