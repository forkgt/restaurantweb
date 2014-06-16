class Cartridge < ActiveRecord::Base
  #All Attributes:
  #========================================================================
  #class CreateCartridges < ActiveRecord::Migration
  #  def change
  #    create_table :cartridges do |t|
  #      t.string :name
  #      t.string :bei
  #      t.integer :rank
  #      t.string :image
  #      t.decimal :price
  #      t.integer :interval
  #
  #      t.timestamps
  #    end
  #  end
  #end

  has_many :subscriptions, as: :subscribable
  has_many :stores, through: :subscriptions

  # Available Cartridge List
  #========================================================================
  # menu_manager     -- Edit Your Menus
  # order_manager    -- Monitor Your Orders
  # close_manager    -- Stop Your Bussiness For A While
  # coupon_manager   -- Manage Your Coupons
  # user_manager     -- Manage Your Users

end
