class CouponsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_store
  before_action :set_coupon, only: [:show, :edit, :update, :destroy]

  # GET /coupons
  # GET /coupons.json
  def index
    @coupons = @store.coupons
  end

  # GET /coupons/1
  # GET /coupons/1.json
  def show
  end

  # GET /coupons/new
  def new
    @coupon = @store.coupons.build
  end

  # GET /coupons/1/edit
  def edit
  end

  # POST /coupons
  # POST /coupons.json
  def create
    @coupon = @store.coupons.create(coupon_params)

    respond_to do |format|
      if @coupon.save
        format.html { redirect_to store_coupons_url(@store), notice: 'Coupon was successfully created.' }
        format.json { render action: 'show', status: :created, location: @coupon }
      else
        format.html { render action: 'new' }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coupons/1
  # PATCH/PUT /coupons/1.json
  def update
    respond_to do |format|
      if @coupon.update(coupon_params)
        format.html { redirect_to store_coupons_url(@store), notice: 'Coupon was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coupons/1
  # DELETE /coupons/1.json
  def destroy
    @coupon.destroy
    respond_to do |format|
      format.html { redirect_to store_coupons_url(@store) }
      format.json { head :no_content }
    end
  end

  private
    def set_store
      @store = Store.find(params[:store_id])
      @cartridge_array = @store.get_cartridge_array
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_coupon
      @coupon = @store.coupons.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coupon_params
      params.require(:coupon).permit(:name, :bei, :rank, :image, :price, :minimum, :start_at, :end_at, :store_id)
    end
end
