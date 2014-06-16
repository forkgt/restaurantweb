class CartridgesController < ApplicationController
  before_action :set_cartridge, only: [:show, :edit, :update, :destroy]

  # GET /cartridges
  # GET /cartridges.json
  def index
    @cartridges = Cartridge.all

    respond_to do |format|
      format.html
      format.json { render json: @cartridges }
    end
  end

  # GET /cartridges/1
  # GET /cartridges/1.json
  def show
  end

  # GET /cartridges/new
  def new
    @cartridge = Cartridge.new
  end

  # GET /cartridges/1/edit
  def edit
  end

  # POST /cartridges
  # POST /cartridges.json
  def create
    @cartridge = Cartridge.new(cartridge_params)

    respond_to do |format|
      if @cartridge.save
        format.html { redirect_to @cartridge, notice: 'Cartridge was successfully created.' }
        format.json { render action: 'show', status: :created, location: @cartridge }
      else
        format.html { render action: 'new' }
        format.json { render json: @cartridge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cartridges/1
  # PATCH/PUT /cartridges/1.json
  def update
    respond_to do |format|
      if @cartridge.update(cartridge_params)
        format.html { redirect_to @cartridge, notice: 'Cartridge was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @cartridge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cartridges/1
  # DELETE /cartridges/1.json
  def destroy
    @cartridge.destroy
    respond_to do |format|
      format.html { redirect_to cartridges_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cartridge
      @cartridge = Cartridge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cartridge_params
      params.require(:cartridge).permit(:name, :bei, :rank, :image, :price, :interval)
    end
end
