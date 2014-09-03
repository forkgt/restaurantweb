class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception




  # ========== Authorization ========================
  before_action :authorize
  delegate :allow?, to: :current_permission
  helper_method :allow?

private
  def current_permission
    @current_permission ||= Permission.new(current_admin)
  end

  def authorize
    unless current_permission.allow?(controller_name, action_name)
      redirect_to root_url, alert: "Not authorized."
    end
  end
  # =================================================




  # ========== Shopping Cart ========================
  # Used in 3 places:
  # QController#store_menus
  # OrdersController#new
  # CartItemsController#create

  def current_cart(store, create)
    Cart.find(session["cart_id_for_store_id_#{store.id}"])
  rescue ActiveRecord::RecordNotFound
    if create
      delivery_type = store.has_delivery_service? ? "delivery" : "pick_up"
      cart = Cart.create(store: store, delivery_fee: 0, delivery_minimum: 0, delivery_type: delivery_type)
      session["cart_id_for_store_id_#{store.id}"] = cart.id
      cart
    end
  end

  # =================================================




  # ========== Deal with Subdomain ==================
  #include UrlHelper
  # =================================================




  # ========== Deal with Layout ==================
  layout :layout_by_resource

  protected

  def get_store_template_name
    if session[:store_template_name].nil?
      @store = Store.find_by domain: request.host
      session[:store_template_name] = @store.templates.take.name
      session[:store_template_framework] = @store.templates.take.framework
    end
    session[:store_template_name]
  end

  def get_store_template_framework
    if session[:store_template_framework].nil?
      @store = Store.find_by domain: request.host
      session[:store_template_name] = @store.templates.take.name
      session[:store_template_framework] = @store.templates.take.framework
    end
    session[:store_template_framework]
  end

  def layout_by_resource
    if devise_controller? && resource_name == :admin && admin_signed_in?
      "admin"
    elsif devise_controller? && resource_name == :user
      "templates/" + get_store_template_name
    elsif ["h", "menus", "coupons", "dish_choices", "dish_features", "payments", "categories", "dishes", "statement_items", "statements"].include?(controller_name)
      "admin"
    elsif ["cartridges", "templates", "subscriptions"].include?(controller_name)
      "feng"
    elsif "stores" == controller_name
      if ["index", "new"].include?(action_name)
        "feng"
      else
        "admin"
      end
    elsif "q" == controller_name
      "templates/" + get_store_template_name
    elsif "orders" == controller_name
      if "orders" == controller_name && ["new", "create"].include?(action_name)
        "templates/" + get_store_template_name
      else
        "admin"
      end
    else
      "application"
    end
  end
  # =================================================

end
