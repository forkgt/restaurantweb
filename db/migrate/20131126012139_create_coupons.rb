class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :name
      t.string :desc
      t.integer :rank
      t.string :avatar
      t.decimal :price, :precision => 8, :scale => 2
      t.decimal :minimum, :precision => 8, :scale => 2
      t.datetime :start_at
      t.datetime :end_at
      t.references :store, index: true

      t.timestamps
    end
  end
end
