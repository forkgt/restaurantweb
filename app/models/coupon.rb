class Coupon < ActiveRecord::Base
  #All Attributes:
  #========================================================================
  #class CreateCoupons < ActiveRecord::Migration
  #  def change
  #    create_table :coupons do |t|
  #      t.string :name
  #      t.string :bei
  #      t.integer :rank
  #      t.string :image
  #      t.decimal :price, :precision => 8, :scale => 2
  #      t.decimal :minimum, :precision => 8, :scale => 2, :default => 0
  #      t.datetime :start_at
  #      t.datetime :end_at
  #      t.references :store, index: true
  #
  #      t.timestamps
  #    end
  #  end
  #end


  belongs_to :store
end
