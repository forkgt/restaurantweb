class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy, :delivery_type]

  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.all
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render action: 'show', status: :created, location: @cart }
      else
        format.html { render action: 'new' }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    # @store is needed for rendering _cart.html.erb
    @store = @cart.store

    # remove user_address from session, make sure to revalidate user address
    session.delete "user_address"

    # destroying a cart with orders create problems for orders management
    if @cart.orders.empty?
      @cart.destroy
    else
      @cart = Cart.new
    end

    respond_to do |format|
      format.js
      format.html { redirect_to carts_url }
      format.json { head :no_content }
    end
  end

  def delivery_type
    @cart.delivery_type = params[:delivery_type]
    @cart.save
    @store = @cart.store

    respond_to do |format|
       format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params.require(:cart).permit(:delivery_type, :delivery_fee, :delivery_minimum, :store_id)
    end
end
