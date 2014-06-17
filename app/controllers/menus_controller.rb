class MenusController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_store
  before_action :set_menu, only: [:show, :edit, :update, :destroy]

  # GET /menus
  # GET /menus.json
  def index
    @menus = @store.menus
  end

  # GET /menus/1
  # GET /menus/1.json
  def show
  end

  # GET /menus/new
  def new
    @menu = @store.menus.build
  end

  # GET /menus/1/edit
  def edit
  end

  # POST /menus
  # POST /menus.json
  def create
    @menu = @store.menus.create(menu_params)

    respond_to do |format|
      if @menu.save
        format.html { redirect_to store_menus_url(@store), notice: 'Menu was successfully created.' }
        format.json { render action: 'show', status: :created, location: @menu }
      else
        format.html { render action: 'new' }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /menus/1
  # PATCH/PUT /menus/1.json
  def update
    respond_to do |format|
      if @menu.update(menu_params)
        format.html { redirect_to store_menus_url(@store), notice: 'Menu was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.json
  def destroy
    @menu.destroy

    respond_to do |format|
      format.html { redirect_to store_menus_url(@store) }
      format.json { head :no_content }
    end
  end

  private
    def set_store
      @store = Store.find(params[:store_id])
      @cartridge_array = @store.get_cartridge_array
    end

    def set_menu
      @menu = @store.menus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_params
      params.require(:menu).permit(:name, :bei, :rank, :image, :store_id,
                                   :hours_attributes => [:id, :name, :bei, :open_at, :close_at, :_destroy])
    end
end
