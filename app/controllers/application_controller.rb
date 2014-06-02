class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

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
      "h"
    elsif ["h", "orders", "menus"].include?(controller_name)
      "h"
    elsif ["stores", "templates", "dish_choices", "dish_features", "coupons", "subscriptions"].include?(controller_name)
      "z"
    else
      "application"
    end
  end
  # =================================================

end
