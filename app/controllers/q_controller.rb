class QController < ApplicationController
  before_action :set_store, only: [:store_home, :store_map, :store_menus, :store_message]

  def index
    #unless request.host == "www.777pos.com"
    #  redirect_to q_store_home_path
    #  return # With return, following code will be executed.
    #end
  end

  def store_message
    @message = params[:message]

    render action: "templates/#{@template_name}/store_message"
  end

  def store_home
    @dishes = Dish.includes(category: {menu: :store}).where("stores.id = ? ", @store.id).where("dishes.image IS NOT NULL")

    render action: "templates/#{@template_name}/store_home"
  end

  def store_menus
    @cart = current_cart(@store, false)
    @menus = @store.menus.includes([{categories: {dishes: [:dish_features, :dish_choices]}}, :hours ])

    render action: "templates/#{@template_name}/store_menus"
  end

  def store_map
    render action: "templates/#{@template_name}/store_map"
  end

  protect_from_forgery :except => [:paypal_notify]

  include ActiveMerchant::Billing::Integrations

  def paypal_notify
    if APP_CONFIG["ibm_mode"] == "test"
      ActiveMerchant::Billing::Base.mode = :test
    elsif APP_CONFIG['ibm_mode'] == "production"
      ActiveMerchant::Billing::Base.mode = :production
    end

    notify = Paypal::Notification.new(request.raw_post)
    order = Order.find(notify.invoice)
    if notify.acknowledge
      begin
        amount_in_db = Money.new ((order.cart.total_price+order.tip)*100).round
        if notify.complete? and amount_in_db == notify.amount
          order.payment_status = 'paid'
          order.updated_at = Time.now
          order.to_fax
        else
          logger.error("Failed to verify Paypal's notification, please investigate")
        end
      rescue => e
        order.payment_status = 'pending'
        raise
      ensure
        order.save
      end
    end

    render :nothing => true
  end

  private
  def set_store
    #@store = Store.find(params[:id])   # Find Store through id in the params
    #@store = Store.find_by_desc(request.subdomain) if request.subdomain.present? && request.subdomain != "www"   # Deal with Subdomain
    @store = Store.find_by domain: request.host
    if @store.nil?
      redirect_to q_index_path
      return
    elsif @store.status == "closed"
      redirect_to q_store_message_path(message: "The store is currently close!")
      return
    else
      @template_name = get_store_template_name
    end
  end

end
