class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:show, :edit, :update, :destroy]

  # GET /cart_items
  # GET /cart_items.json
  def index
    @cart_items = CartItem.all
  end

  # GET /cart_items/1
  # GET /cart_items/1.json
  def show
  end

  # GET /cart_items/new
  def new
    @cart_item = CartItem.new
  end

  # GET /cart_items/1/edit
  def edit
  end

  # POST /cart_items
  # POST /cart_items.json
  def create
    store_id = params[:store_id].to_i
    @cart = current_cart(store_id, true)

    if params[:dish_id]
      dish = Dish.find(params[:dish_id])
      note = params[:note]
      price_adjustment = params[:price_adjustment].to_d
      quantity = params[:quantity].to_i

      @cart_item = @cart.add_dish(dish, dish.name, dish.price + price_adjustment, quantity, note)
    elsif params[:coupon_id]

    end

    # Use different js for different templates/framework
    @framework = @cart.store.templates.take.framework

    respond_to do |format|
      if @cart_item
        if @cart_item.save
          format.js   { @current_item = @cart_item, @framework }
          format.html { redirect_to @cart_item, notice: 'Cart item was successfully created.' }
          format.json { render action: 'show', status: :created, location: @cart_item }
        else
          format.js   { @current_item = @cart_item }
          format.html { render action: 'new' }
          format.json { render json: @cart_item.errors, status: :unprocessable_entity }
        end
      else
        format.js {}
      end
    end
  end

  # PATCH/PUT /cart_items/1
  # PATCH/PUT /cart_items/1.json
  def update
    respond_to do |format|
      if @cart_item.update(cart_item_params)
        format.html { redirect_to @cart_item, notice: 'Cart item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cart_items/1
  # DELETE /cart_items/1.json
  def destroy
    @cart_item.destroy
    @cart = @cart_item.cart

    respond_to do |format|
      format.js
      format.html { redirect_to cart_items_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_item_params
      params.require(:cart_item).permit(:name, :note, :price, :quantity, :cart_id, :cart_itemable_id)
    end
end
