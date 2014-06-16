class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception




  # ========== Authorization ========================
  before_filter :authorize
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
  def current_cart(store_id, create)
    Cart.includes(cart_items: :cart_itemable).find(session["cart_id_for_store_id_#{store_id}"])
  rescue ActiveRecord::RecordNotFound
    if create
      store = Store.find(store_id)
      cart = Cart.create(store_id: store_id, delivery_fee: store.delivery_fee, delivery_type: "delivery")
      session["cart_id_for_store_id_#{store_id}"] = cart.id
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

  def layout_by_resource
    if devise_controller? && resource_name == :admin && admin_signed_in?
      "admin"
    elsif devise_controller? && resource_name == :user && action_name == :edit
      store = Store.find_by domain: request.host
      if store.nil?
        "admin"
      else
        template = store.get_current_template
        "templates/" + template
      end

    elsif ["h", "orders", "menus", "coupons", "dish_choices", "dish_features", "payments", "categories", "dishes", "statement_items", "statements"].include?(controller_name)
      "admin"
    elsif ["cartridges", "templates", "subscriptions"].include?(controller_name)
      "feng"
    elsif "stores" == controller_name
      if ["index", "new"].include?(action_name)
        "feng"
      else
        "admin"
      end
    else
      "application"
    end
  end
  # =================================================

end
