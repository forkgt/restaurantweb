class QController < ApplicationController
  before_action :set_store, only: [:store_home, :store_map, :store_menus, :store_intro, :store_message, :check_address, :reset_address]

  def index
    #unless request.host == "www.777pos.com"
    #  redirect_to q_store_home_path
    #  return # With return, following code will be executed.
    #end

    render layout: "application"
  end

  def store_message
    @message = params[:message]

    render action: "templates/#{@template_name}/store_message"
  end

  def store_home
    @dishes = Dish.includes(category: {menu: :store}).where("stores.id = ? ", @store.id).where("dishes.image IS NOT NULL").references(category: {menu: :store})

    render action: "templates/#{@template_name}/store_home"
  end

  def store_menus
    @cart = current_cart(@store, false)
    @menus = @store.menus.includes([{categories: {dishes: [:dish_features, :dish_choices]}}, :hours ])

    # Decide if the store has at least one of the two ordering services: delivery or pick_up
    @store_has_order_service = @store.has_delivery_service? || @store.has_pick_up_service?

    render action: "templates/#{@template_name}/store_menus"
  end

  def store_map
    render action: "templates/#{@template_name}/store_map"
  end

  def store_intro
    render action: "templates/#{@template_name}/store_intro"
  end

  def check_address
    # good
    # not_complete
    # not_valid
    # too_far

    if params[:address1].present? && params[:city].present? && params[:zip].present?


      user_address_str = [params[:address1], params[:city], "TX", "US", params[:zip]].compact.join(', ')
      store_address = @store.address
      if store_address.geocoded?
        distance = store_address.distance_from(user_address_str)

        if distance.nan?
          @result = "not_valid"
        else
          @result= "too_far"
          @store.delivery_rules.each do |dr|
            # If distance is larger than radius, go to a larger radius
            # If distance is in this radius, finish now, don't go to a larger radius
            if distance > dr.delivery_radius
              next
            else
              @result = "good"
              @cart = current_cart(@store, false)
              @cart.update(delivery_fee: dr.delivery_fee, delivery_minimum: dr.delivery_minimum)
              session[:user_address] = Hash[address1: params[:address1], city: params[:city], zip: params[:zip]]

              break
            end
          end
        end
      end
    else
      @result = "not_complete"
    end

    respond_to do |format|
      format.js { render action: "templates/#{@template_name}/check_address", template: "q/templates/public/check_address" }
    end
  end

  def reset_address
    session.delete "user_address"
    @cart = current_cart(@store, false)
    @cart.update(delivery_fee: 0, delivery_minimum: 0)

    respond_to do |format|
      format.js { render action: "templates/#{@template_name}/reset_address", template: "q/templates/public/reset_address" }
    end
  end


  protect_from_forgery :except => [:order_paypal_notify, :statement_paypal_notify]

  include ActiveMerchant::Billing::Integrations
  if APP_CONFIG["ibm_mode"] == "test"
    ActiveMerchant::Billing::Base.mode = :test
  elsif APP_CONFIG['ibm_mode'] == "production"
    ActiveMerchant::Billing::Base.mode = :production
  end

  def order_paypal_notify
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
          logger.error("Failed to verify Paypal's notification for orders.")
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

  def statement_paypal_notify
    notify = Paypal::Notification.new(request.raw_post)
    statement = Statement.find(notify.invoice)
    if notify.acknowledge
      begin
        amount_in_db = Money.new (statement.total_price*100).round
        if notify.complete? and amount_in_db == notify.amount
          statement.payment_type = 'paypal'
          statement.payment_status = 'paid'
          statement.updated_at = Time.now
        else
          logger.error("Failed to verify Paypal's notification for statements.")
        end
      rescue => e
        raise
      ensure
        statement.save
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
    elsif @store.status == "closed" && action_name != 'store_message'
      redirect_to q_store_message_path(message: "The store is currently closed!")
      return
    else
      @template_name = get_store_template_name
    end
  end

end
