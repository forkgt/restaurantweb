class Payment < ActiveRecord::Base
  #All Attributes:
  #========================================================================
  #class CreatePayments < ActiveRecord::Migration
  #  def change
  #    create_table :payments do |t|
  #      t.string :name
  #      t.integer :rank
  #      t.string :bei
  #      t.string :image
  #      t.string :account
  #
  #      t.timestamps
  #    end
  #  end
  #end


  belongs_to :store


end
