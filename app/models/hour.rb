class Hour < ActiveRecord::Base
  #All Attributes:
  #========================================================================
  #class CreateHours < ActiveRecord::Migration
  #  def change
  #    create_table :hours do |t|
  #      t.string :name
  #      t.string :bei
  #      t.string :open_at
  #      t.string :close_at
  #      t.references :hourable, polymorphic: true, index: true
  #
  #      t.timestamps
  #    end
  #  end
  #end



  belongs_to :hourable, polymorphic: true
end
