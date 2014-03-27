class Store < ActiveRecord::Base
  #All Attributes:
  #========================================================================
  #class CreateStores < ActiveRecord::Migration
  #  def change
  #    create_table :stores do |t|
  #      t.string :name
  #      t.string :desc
  #      t.integer :rank
  #      t.string :avatar
  #      t.string :phone
  #      t.string :fax
  #      t.decimal :delivery_minimum
  #      t.decimal :delivery_fee, :default => 0, :precision => 8, :scale => 2
  #      t.integer :delivery_radius
  #      t.references :admin, index: true
  #
  #      t.timestamps
  #    end
  #  end
  #end


  belongs_to :admin

  has_one :address, :as => :addressable

  has_many :subscriptions
  has_many :templates, through: :subscriptions, :source => :subscribable, :source_type => 'Template'
  has_many :dish_features
  has_many :dish_choices

  has_many :menus, :dependent => :destroy, :order => :rank
  has_many :orders
  has_many :carts

  accepts_nested_attributes_for :subscriptions
  accepts_nested_attributes_for :address

  def get_current_template
    templates.first.name
  end

  def has_delivery_service?
    true
  end

  def has_melivery_service?
    false
  end

  def has_pick_up_service?
    false
  end

  def has_express_service?
    false
  end

end
