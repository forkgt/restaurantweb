class OrdersController < ApplicationController
  before_action :set_store
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    if params[:start_date].present? && params[:end_date].present?
      sd = Time.parse params[:start_date]
      ed = Time.parse params[:end_date]
    else
      sd = Time.now
      ed = Time.now
    end

    @orders = @store.orders.where(:created_at => sd.beginning_of_day..ed.end_of_day).includes([{cart: :cart_items }, :user])
    @not_paid_count = Statement.where(:payment_status => "not_paid").count
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    if params[:cart_id]
      @cart = Cart.find(params[:cart_id])
    else
      @cart = current_cart(@store, false)
    end

    # Redirect if the cart is empty
    unless @cart
      redirect_to q_store_menus_url, notice: "Your Cart is Empty!"
      return
    end

    # Redirect if the cart doesn't meet minimum
    if @cart.delivery_type == 'delivery' && @cart.total_price < @cart.delivery_minimum
      redirect_to q_store_menus_url, notice: "The order doesn't meet minimum!"
      return
    end

    if user_signed_in?
      current_user.build_address(session[:user_address]) if @cart.delivery_type == 'delivery' && current_user.address.nil?
      @order = Order.new(cart: @cart, store: @store, user: current_user)
    else
      user = User.new
      user.build_address(session[:user_address]) if @cart.delivery_type == 'delivery'
      @order = Order.new(cart: @cart, store: @store, user: user)
    end

    render template: "q/templates/#{@template_name}/store_order"
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new order_params

    if @order.user.email.blank? && @order.user.password.blank? && @order.user.password_confirmation.blank?
      @order.user.email = "guest_#{Time.now.to_i}#{rand(99)}@777pos.com"
      @order.user.password = "guest_password"
      @order.user.password_confirmation = "guest_password"

      # Skip sending emails
      # Add it if devise comfirmable is on
      #@order.user.skip_confirmation!
    end

    # Add State and Country for validations in Model Address
    unless @order.user.address.nil?
      @order.user.address.state = "TX"
      @order.user.address.country = "US"
    end

    # Need to validate the phone number for the order
    #@order.user.validate_phone = true

    # Set the status of this order
    @order.transfer_status = "unconfirmed"

    respond_to do |format|
      if @order.save
        # Clear the cart and user address in the session
        session.delete "cart_id_for_store_id_#{@order.store_id}"
        session.delete "user_address"

        if @order.payment_type == 'paypal'
          # Redirect to Paypal Page
          format.html { redirect_to @order.paypal_url }
        else
          # Send Fax through Interfax
          @order.to_fax

          #format.html { redirect_to store_order_url(@store, @order), notice: 'Order was successfully created.' }
          format.html { redirect_to q_store_message_path(message: "The order has been taken!") }
          format.json { render json: @order, status: :created, location: @order }
        end
      else
        @cart = current_cart(@store, false)
        @order.user.email = ""

        format.html { render template: "q/templates/#{@template_name}/store_order"}
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to store_order_url(@store, @order), notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  private

    def set_store
      @store = Store.find(params[:store_id])
      @cartridge_array = @store.get_cartridge_array
      @template_name = get_store_template_name
    end

  # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:note, :payment_type, :payment_status, :transfer_status, :tip, :store_id, :cart_id, :user_id,
                                    :user_attributes => [:id, :firstname, :lastname, :phone, :address_attributes => [:id, :address1, :address2, :city, :zip]])
    end
end
