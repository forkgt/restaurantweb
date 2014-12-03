class CategoriesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_menu
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @categories = @menu.categories.includes([:menu, dishes: [:dish_features, :dish_choices, :category] ])
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = @menu.categories.build
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = @menu.categories.create(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to menu_categories_url(@menu), notice: 'Category was successfully created.' }
        format.json { render action: 'show', status: :created, location: @category }
      else
        format.html { render action: 'new' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to menu_categories_url(@menu), notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy

    respond_to do |format|
      format.html { redirect_to menu_categories_url(@menu) }
      format.json { head :no_content }
    end
  end

  private
    def set_menu
      @menu = Menu.find(params[:menu_id])
      @store = @menu.store
      # @cartridge_array = @store.get_cartridge_array
    end

    def set_category
      @category = @menu.categories.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :bei, :rank, :image, :menu_id)
    end
end
