class QController < ApplicationController

  before_action :set_store, only: [:store_home, :store_map, :store_menus, :store_order]

  def index
    @stores = Store.all
  end

  def stores
  end

  def store_home
    # set erb for this store
    render action: "templates/#{@template}/store_home", layout: "templates/#{@template}"
  end

  def store_menus
    # set erb for this store
    render action: "templates/#{@template}/store_menus", layout: "templates/#{@template}"
  end

  def store_map
    # set erb for this store
    render action: "templates/#{@template}/store_map", layout: "templates/#{@template}"
  end

  def store_order
    @has_cart = true # Show the cart toggle

    @cart = current_cart(@store.id, false)

    # Redirect if the cart is empty
    unless @cart
      redirect_to store_menus_url, notice: "Your Cart is Empty!"
      return
    end

    # Redirect if the cart doesn't meet minimum
    if @cart.delivery_type == 'delivery' && @cart.total_price < @cart.store.delivery_minimum
      redirect_to store_menus_url, notice: "The order doesn't meet minimum!"
      return
    end

    if user_signed_in?
      current_user.build_address if @cart.delivery_type == 'delivery' && current_user.address.nil?
      @order = Order.new(:cart => @cart, :store => @cart.store, :user => current_user)
    else
      user = User.new
      user.build_address if @cart.delivery_type == 'delivery'
      @order = Order.new(:cart => @cart, :store => @cart.store, :user => user)
    end

    # set erb for this store
    render action: "templates/#{@template}/store_order", layout: "templates/#{@template}"
  end

  private
  def set_store
    #@store = Store.find(params[:id])   # Find Store through id in the params
    @store = Store.find_by_desc(request.subdomain) if request.subdomain.present? && request.subdomain != "www"
    @template = @store.get_current_template
    @cart = current_cart(@store.id, false)
  end

end
