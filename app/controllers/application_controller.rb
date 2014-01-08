class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # ========== Shopping Cart ===========

  def current_cart(store_id, create)
    Cart.find(session["cart_id_for_store_id_#{store_id}"])
  rescue ActiveRecord::RecordNotFound
    if create
      store = Store.find(store_id)
      cart = Cart.create(store_id: store_id, delivery_fee: store.delivery_fee, delivery_type: "delivery")
      session["cart_id_for_store_id_#{store_id}"] = cart.id
      cart
    end
  end

  # ========== Deal with Subdomain ===========

  include UrlHelper

end
