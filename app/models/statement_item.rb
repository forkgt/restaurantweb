class StatementItem < ActiveRecord::Base
  #All Attributes:
  #========================================================================
  #class CreateStatementItems < ActiveRecord::Migration
  #  def change
  #    create_table :statement_items do |t|
  #      t.integer :day
  #      t.string :name
  #      t.string :note
  #      t.decimal :price
  #      t.integer :quantity
  #      t.references :statement, index: true
  #
  #      t.timestamps
  #    end
  #  end
  #end

  belongs_to :statement

  def total_price
    price * quantity
  end
end
