class HController < ApplicationController
  # Authenticate Devise Admin
  before_action :authenticate_admin!

  def index
    @store = current_admin.stores.first
  end

  def profile
  end

  def store
    @store = Store.find(params[:id])
    @orders_of_today = @store.orders.where('DATE(created_at) = ?', Date.today)
    @orders_of_yesterday = @store.orders.where('DATE(created_at) = ?', Date.yesterday)
  end

end
