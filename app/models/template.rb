class Template < ActiveRecord::Base
  #All Attributes:
  #========================================================================
  #class CreateTemplates < ActiveRecord::Migration
  #  def change
  #    create_table :templates do |t|
  #      t.string :name
  #      t.string :bei
  #      t.string :framework
  #      t.integer :rank
  #      t.string :image
  #      t.decimal :price , precision: 8, scale: 2
  #      t.integer :interval, default: 12
  #
  #      t.timestamps
  #    end
  #  end
  #end


  has_many :subscriptions, as: :subscribable
  has_many :stores, through: :subscriptions

  # When you add/delete a templates, check these places:
  # /app/views/q/templates/yumasianbistro/*
  # /app/views/layouts/templates/yumasianbistro.html.erb
  # /app/assets/stylesheets/templates/yumasianbistro.css.scss
  # /app/assets/javascripts/templates/yumasianbistro.js
end
