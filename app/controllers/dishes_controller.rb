class DishesController < ApplicationController
  before_action :set_category
  before_action :set_dish, only: [:show, :edit, :update, :destroy]

  layout "h"

  # GET /dishes
  # GET /dishes.json
  def index
    @dishes = @category.dishes
  end

  # GET /dishes/1
  # GET /dishes/1.json
  def show
  end

  # GET /dishes/new
  def new
    @dish = @category.dishes.build
  end

  # GET /dishes/1/edit
  def edit
  end

  # POST /dishes
  # POST /dishes.json
  def create
    @dish = @category.dishes.create(dish_params)

    respond_to do |format|
      if @dish.save
        #format.html { redirect_to category_dishes_url(@category), notice: 'Dish was successfully created.' }
        format.html { redirect_to menu_categories_url(@category.menu), notice: 'Dish was successfully updated.' }
        format.json { render action: 'show', status: :created, location: @dish }
      else
        format.html { render action: 'new' }
        format.json { render json: @dish.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dishes/1
  # PATCH/PUT /dishes/1.json
  def update
    respond_to do |format|
      if @dish.update(dish_params)
        #format.html { redirect_to category_dishes_url(@category), notice: 'Dish was successfully updated.' }
        format.html { redirect_to menu_categories_url(@category.menu), notice: 'Dish was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @dish.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dishes/1
  # DELETE /dishes/1.json
  def destroy
    @dish.destroy
    respond_to do |format|
      format.html { redirect_to category_dishes_url(@category) }
      format.json { head :no_content }
    end
  end

  private
    def set_category
      @category = Category.find(params[:category_id])
      @store = @category.menu.store
    end

    def set_dish
      @dish = @category.dishes.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dish_params
      params.require(:dish).permit( :name, :desc, :rank, :avatar, :price, :category_id,
                                   :dish_feature_ids => [], :dish_choice_ids => [] )
    end
end
