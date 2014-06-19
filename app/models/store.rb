class Store < ActiveRecord::Base
  #All Attributes:
  #========================================================================
  #class CreateStores < ActiveRecord::Migration
  #  def change
  #    create_table :stores do |t|
  #      t.string :name
  #      t.string :bei
  #      t.integer :rank
  #      t.string :image
  #      t.string :domain
  #      t.string :phone
  #      t.string :fax
  #      t.string :status, default: "normal"
  #      t.string :uuid
  #      t.decimal :delivery_minimum, :default => 0, :precision => 8, :scale => 2
  #      t.decimal :delivery_fee, :default => 0, :precision => 8, :scale => 2
  #      t.integer :delivery_radius
  #
  #      t.references :admin, index: true
  #
  #      t.timestamps
  #    end
  #  end
  #end

  validates_presence_of :name
  validates :phone, presence: true, numericality: { only_integer: true }, length: { is: 10 }
  validates :fax, presence: true, numericality: { only_integer: true }, length: { is: 10 }

  belongs_to :admin

  has_one :address, :as => :addressable
  accepts_nested_attributes_for :address
  validates_associated :address

  has_many :dish_features
  has_many :dish_choices
  has_many :payments
  has_many :statements
  has_many :menus, -> { order(:rank) }, :dependent => :destroy
  has_many :coupons
  has_many :carts

  has_many :orders
  has_many :users, -> { uniq }, :through => :orders

  has_many :subscriptions
  has_many :cartridges, through: :subscriptions, :source => :subscribable, :source_type => 'Cartridge'
  has_many :templates, through: :subscriptions, :source => :subscribable, :source_type => 'Template'
  accepts_nested_attributes_for :subscriptions

  # ===== If one store can have only one template =====
  #has_one :address, :as => :addressable
  #has_one :subscription
  #has_one :template, through: :subscription, :source => :subscribable, :source_type => 'Template'


  def get_current_template
    templates.take.name
  end

  def get_cartridge_array
    cs = Array.new

    cartridges.each do |c|
      cs << c.name
    end

    cs
  end

  def get_paypal_account
    payments.find_by_name("paypal").account
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
