class AddFaxToStores < ActiveRecord::Migration
  def change
    add_column :stores, :has_fax, :boolean, null: false, default: false
    add_column :stores, :fax_usr, :string
    add_column :stores, :fax_pwd, :string
  end
end
