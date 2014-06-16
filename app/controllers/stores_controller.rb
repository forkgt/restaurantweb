class StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :destroy]

  # GET /stores
  # GET /stores.json
  def index
    @stores = Store.all
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
    @statements = Statement.where(:payment_status => "not_paid")

  end

  # GET /stores/new
  def new
    @store = Store.new
    @store.build_address

    @templates = Template.all
    @cartridges = Cartridge.all
  end

  # GET /stores/1/edit
  def edit
    if @store.address.nil?
      @store.build_address
    end

    @templates = Template.all
    @cartridges = Cartridge.all
  end

  # POST /stores
  # POST /stores.json
  def create
    @store = Store.new(store_params)

    respond_to do |format|
      if @store.save
        format.html { redirect_to @store, notice: 'Store was successfully created.' }
        format.json { render action: 'show', status: :created, location: @store }
      else
        format.html { render action: 'new' }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stores/1
  # PATCH/PUT /stores/1.json
  def update
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to @store, notice: 'Store was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json
  def destroy
    @store.destroy
    respond_to do |format|
      format.html { redirect_to stores_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.find(params[:id])
      @cartridge_array = @store.get_cartridge_array
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_params
      params.require(:store).permit(:name, :bei, :domain, :rank, :image, :phone, :fax, :status, :delivery_minimum, :delivery_fee, :delivery_radius,
                                    :admin_id, :uuid,
                                    :address_attributes => [:id, :address1, :address2, :city, :state, :country, :zip],
                                    :template_ids => [], :cartridge_ids => [] )
    end
end
