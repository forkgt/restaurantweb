class AddDetailsToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :firstname, :string
    add_column :admins, :lastname, :string
    add_column :admins, :phone, :string
    add_column :admins, :image, :string
  end
end
