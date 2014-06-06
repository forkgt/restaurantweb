class Menu < ActiveRecord::Base
  #All Attributes:
  #========================================================================
  #class CreateMenus < ActiveRecord::Migration
  #  def change
  #    create_table :menus do |t|
  #      t.string :name
  #      t.string :bei
  #      t.integer :rank
  #      t.string :image
  #      t.references :store, index: true
  #
  #      t.timestamps
  #    end
  #  end
  #end


  include Hourable

  belongs_to :store

  has_many :categories, -> { order(:rank) }, :dependent => :destroy

  has_many :hours, :dependent => :destroy, :as => :hourable
  accepts_nested_attributes_for :hours, :allow_destroy => true

end
