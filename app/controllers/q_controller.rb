class QController < ApplicationController

  before_action :set_store, only: [:store_home, :store_map, :store_menus, :store_order, :store_order_success, :store_order_failure, :store_order_cancel]

  def index
    # Match the host to all stores
    # Yes => Go to the matched store
    # No  => Go to the index page
    #@store = Store.find_by domain: request.host
    #if @store.nil?
    #  @stores = Store.all
    #else
    #  redirect_to q_store_home_path
    #  return
    #end
    @stores = Store.all
  end

  def missing
  end

  def closed
  end

  def store_home
    @dishes = nil
    # set erb for this store
    render action: "templates/#{@template}/store_home", layout: "templates/#{@template}"
  end

  def store_menus
    @menus = @store.menus.includes(categories: {dishes: [:dish_features, :dish_choices]})
    # set erb for this store
    render action: "templates/#{@template}/store_menus", layout: "templates/#{@template}"
  end

  def store_map
    # set erb for this store
    render action: "templates/#{@template}/store_map", layout: "templates/#{@template}"
  end

  # If success after a customer order was submitted
  def store_order_success
    # set erb for this store
    render action: "templates/#{@template}/store_order_success", layout: "templates/#{@template}"
  end

  # If failure after a customer order was submitted
  def store_order_failure
    # set erb for this store
    render action: "templates/#{@template}/store_order_failure", layout: "templates/#{@template}"
  end

  # If canncelled after a customer order was submitted
  def store_order_cancel
    # set erb for this store
    render action: "templates/#{@template}/store_order_cancel", layout: "templates/#{@template}"
  end


  protect_from_forgery :except => [:paypal_notify]

  include ActiveMerchant::Billing::Integrations

  def paypal_notify
    ActiveMerchant::Billing::Base.mode = :test
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

    # Check if there is session[:store] and session[:store][:domain] matches the host name
    # Yes => No need to reload the store
    # No  => Must reload the store
    @store = Store.find_by domain: request.host
    if @store.nil?
      redirect_to q_missing_path
      return
    elsif @store.status == "closed"
      redirect_to q_closed_path
      return
    else
      @template = @store.get_current_template
      @cart = current_cart(@store.id, false)
    end
  end

end
