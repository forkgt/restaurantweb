class Order < ActiveRecord::Base
  #All Attributes:
  #========================================================================
  #class CreateOrders < ActiveRecord::Migration
  #  def change
  #    create_table :orders do |t|
  #      t.string :note
  #      t.string :payment_type, :default => 'cash', :null => false
  #      t.string :payment_status, :default => 'not_paid', :null => false
  #      t.decimal :tip, :default => 0, :precision => 8, :scale => 2
  #      t.references :store, index: true
  #      t.references :cart, index: true
  #      t.references :user, index: true
  #
  #      t.timestamps
  #    end
  #  end
  #end
  #
  #class AddTransferStatusToOrders < ActiveRecord::Migration
  #  def change
  #    add_column :orders, :transfer_status, :string
  #  end
  #end

  belongs_to :store
  belongs_to :cart
  belongs_to :user

  accepts_nested_attributes_for :user

  # In order to use number_to_currency
  include ActionView::Helpers::NumberHelper
  extend ActionView::Helpers::NumberHelper
  include Rails.application.routes.url_helpers

  # Solve One-Two-One association's create_model_and_update_nested_model Problem
  def user_attributes=(attributes)
    if attributes['id'].present?
      self.user = User.find(attributes['id'])
    end
    super
  end

  def payment_types
    [['Cash ', 'cash'], ['PayPal ', 'paypal']]
  end

  TIP_RATES = [['Tip cash', 0], ['Tip $1.00', 1], ['Tip $2.00', 2], ['Tip $3.00', 3], ['Tip $4.00', 4], ['Tip $5.00', 5],
               ['Tip $6.00', 6], ['Tip $7.00', 7], ['Tip $8.00', 8], ['Tip $9.00', 9], ['Tip $10.00', 10]]


  def paypal_url
    values = {
        :business       => APP_CONFIG['paypal_email'],
        :cancel_return  => home_paypal_cancel_url(:host => APP_CONFIG['domain']),
        :charset        => 'utf-8',
        :cmd            => '_cart',
        :currency_code  => 'USD',
        :custom         => '',
        :image_url      => "https://meals4.me/assets/mfm_logo.png",
        :invoice        => id,
        :lc             => 'US',
        :no_shipping    => 0,
        :no_note        => 1,
        :notify_url     => home_paypal_notify_url(:host => APP_CONFIG['domain']),
        :num_cart_items => cart.cart_items.size,
        :return         => home_stores_url(:host => APP_CONFIG['domain']),
        :rm             => 2,
        :secret         => 'hello_token',
        :tax_cart       => number_with_precision(cart.tax, :precision => 2),
        :upload         => 1,
    }

    cart.cart_items.each_with_index do |item, index|
      values.merge!({
                        "amount_#{index+1}" => item.price,
                        "discount_rate_#{index+1}" => 0,
                        "item_name_#{index+1}" => item.name,
                        "item_number_#{index+1}" => item.id,
                        "quantity_#{index+1}" => item.quantity,
                        "shipping_#{index+1}" => 0
                    })
    end

    cart_size = cart.cart_items.size
    values.merge!({
                      "amount_#{cart_size+1}" => cart.delivery_fee,
                      "discount_rate_#{cart_size+1}" => 0,
                      "item_name_#{cart_size+1}" => 'Delivery fee',
                      "item_number_#{cart_size+1}" => '',
                      "quantity_#{cart_size+1}" => 1,
                      "shipping_#{cart_size+1}" => 0,

                      "amount_#{cart_size+2}" => tip,
                      "discount_rate_#{cart_size+2}" => 0,
                      "item_name_#{cart_size+2}" => 'Tip',
                      "item_number_#{cart_size+2}" => '',
                      "quantity_#{cart_size+2}" => 1,
                      "shipping_#{cart_size+2}" => 0
                  })

    APP_CONFIG['paypal_base_url'] + "?" + values.to_query
  end

  # Use class method because of delayed_job
  def to_fax

    html = File.open(Rails.root.join('app/views/orders/_fax.html.erb')).read
    template = ERB.new(html)
    str = template.result(binding)
    client = Savon.client(log: false, wsdl: APP_CONFIG["interfax_url"])  # Turn off log for security

    if APP_CONFIG["ibm_mode"] == "test"
      response_interfax = client.call(:send_char_fax, :message => {'Username' => APP_CONFIG["interfax_usr"], 'Password' => APP_CONFIG["interfax_pwd"],
                                                                   'FaxNumber' => '9790000000', 'Data' => str, 'FileType' => 'HTML'})
    elsif APP_CONFIG["ibm_mode"] == "production"
      response_interfax = client.call(:send_char_fax, :message => {'Username' => APP_CONFIG["interfax_usr"], 'Password' => APP_CONFIG["interfax_pwd"],
                                                                   'FaxNumber' => self.store.fax, 'Data' => str, 'FileType' => 'HTML'})
    end

    if response_interfax.body[:send_char_fax_response][:send_char_fax_result].to_i > 0
      # Fax succeed
      self.transfer_status= "good_fax"
    else
      # Fax failed
      self.transfer_status= "bad_fax"
    end
    self.save

  end

end
