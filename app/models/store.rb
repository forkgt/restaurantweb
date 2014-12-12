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
  #
  #class RemoveDeliveryRuleFromStores < ActiveRecord::Migration
  #  def up
  #    remove_column :stores, :delivery_fee, :decimal
  #    remove_column :stores, :delivery_minimum, :decimal
  #    remove_column :stores, :delivery_radius, :integer
  #  end
  #
  #  def down
  #    add_column :stores, :delivery_fee, :decimal, :default => 0, :precision => 8, :scale => 2
  #    add_column :stores, :delivery_minimum, :decimal, :default => 0, :precision => 8, :scale => 2
  #    add_column :stores, :delivery_radius, :integer
  #  end
  #end
  #
  # class AddFaxToStores < ActiveRecord::Migration
  #   def change
  #     add_column :stores, :has_fax, :boolean, null: false, default: false
  #     add_column :stores, :fax_usr, :string
  #     add_column :stores, :fax_pwd, :string
  #   end
  # end



  validates_presence_of :name
  validates :phone, presence: true, numericality: { only_integer: true }, length: { is: 10 }
  validates :fax, presence: true, numericality: { only_integer: true }, length: { is: 10 }

  mount_uploader :image, AvatarUploader

  belongs_to :admin

  has_one :address, :as => :addressable
  accepts_nested_attributes_for :address
  # If active, store could not be updated without address filled out
  #validates_associated :address

  has_many :delivery_rules, -> { order(:rank) }
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

  def get_cartridge_array
    cs = Array.new

    cartridges.each do |c|
      cs << c.name
    end

    cs
  end

  def has_this_cartridge?(name)
    get_cartridge_array.include? name
  end

  def get_paypal_account
    payments.find_by_name("paypal").account
  end

  def has_delivery_service?
    get_cartridge_array.include? "delivery_service"
  end

  def has_pick_up_service?
    get_cartridge_array.include? "pick_up_service"
  end


  def has_statements_not_paid?
    statements.where(:payment_status => "not_paid").count > 0
  end

end
