class Menu < ActiveRecord::Base
  #All Attributes:
  #========================================================================
  #class CreateMenus < ActiveRecord::Migration
  #  def change
  #    create_table :menus do |t|
  #      t.string :name
  #      t.string :desc
  #      t.integer :rank
  #      t.string :avatar
  #      t.references :store, index: true
  #
  #      t.timestamps
  #    end
  #  end
  #end


  belongs_to :store

  has_many :categories, :dependent => :destroy, :order => :rank
end
