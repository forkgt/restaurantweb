class Statement < ActiveRecord::Base
  #All Attributes:
  #========================================================================
  #class CreateStatements < ActiveRecord::Migration
  #  def change
  #    create_table :statements do |t|
  #      t.integer :year
  #      t.integer :month
  #      t.string :payment_type
  #      t.string :payment_status
  #      t.string :invoice
  #      t.references :store, index: true
  #
  #      t.timestamps
  #    end
  #  end
  #end

  # In order to use path and url
  include Rails.application.routes.url_helpers


  validates_presence_of :month, :year, :store

  belongs_to :store

  has_many :statement_items, -> { order(:day) }, dependent: :destroy

  PAYMENT_TYPE_OPTIONS = [['Cash', 'cash'], ['Paypal', 'paypal']]
  PAYMENT_STATUS_OPTIONS = [['Not Paid', 'not_paid'], ['Paid', 'paid']]
  YEAR_OPTIONS = [2014, 2015, 2016, 2017, 2018, 2019, 2020]
  MONTH_OPTIONS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

  def total_price
    statement_items.to_a.sum { |item| item.total_price }
  end

  def paypal_url
    if APP_CONFIG["ibm_mode"] == "test"
      paypal_email = 'wanfenghuaian-facilitator@hotmail.com'
    elsif APP_CONFIG['ibm_mode'] == "production"
      paypal_email = APP_CONFIG['paypal_email']
    end

    values = {
        :business       => paypal_email,
        :cancel_return  => q_store_home_url(:host => store.domain),
        :charset        => 'utf-8',
        :cmd            => '_cart',
        :currency_code  => 'USD',
        :custom         => '',
        #:image_url      => "https://meals4.me/assets/mfm_logo.png",
        :invoice        => id,
        :lc             => 'US',
        :no_shipping    => 0,
        :no_note        => 1,
        :notify_url     => q_statement_paypal_notify_url(:host => store.domain),
        :num_cart_items => 1,
        :return         => q_store_home_url(:host => store.domain),
        :rm             => 2,
        :secret         => 'hello_token',
        :tax_cart       => 0,
        :upload         => 1,
    }

    values.merge!({ "amount_1" => total_price,
                    "discount_rate_1" => 0,
                    "item_name_1" => "#{year}-#{month} @ #{store.name}",
                    "item_number_1" => id,
                    "quantity_1" => 1,
                    "shipping_1" => 0 })

    if APP_CONFIG["ibm_mode"] == "test"
      APP_CONFIG['paypal_sandbox_base_url'] + "?" + values.to_query
    elsif APP_CONFIG['ibm_mode'] == "production"
      APP_CONFIG['paypal_base_url'] + "?" + values.to_query
    end
  end

  def self.generate_reports
    y = (Time.now - 1.month).year
    m = (Time.now - 1.month).month

    Store.all.each do |store|
      os = Statement.find_by_year_and_month_and_store_id(y, m, store.id)
      if os.nil?
        # Calculate Fax Fee
        ns = Statement.create(year: y, month: m, payment_status: "not_paid", store: store)
        b = Time.new(y, m)
        (1 .. Time.days_in_month(m, y)).each do |n|
          c = Order.where(:created_at => b + (n-1).days .. b + n.days, store_id: store.id, transfer_status: "good_fax").count
          ns.statement_items.create(day: n, price: 0.1, quantity: c, note: "good", name: "fax") if c > 0
        end

        # Calculate Subscription Fee
        store.subscriptions.each do |subscription|
          ns.statement_items.create(day: 1, price: subscription.subscribable.price, quantity: 1, note: "hello", name: subscription.subscribable.name)
        end
      end
    end
  end
end
