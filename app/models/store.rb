class Store < ActiveRecord::Base
  belongs_to :admin

  has_one :address, :as => :addressable

  has_many :subscriptions
  has_many :templates, through: :subscriptions, :source => :subscribable, :source_type => 'Template'

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
