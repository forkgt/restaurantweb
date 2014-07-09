class DishChoicesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_store
  before_action :set_dish_choice, only: [:show, :edit, :update, :destroy]

  # GET /dish_choices
  # GET /dish_choices.json
  def index
    @dish_choices = @store.dish_choices.includes(:store)
  end

  # GET /dish_choices/1
  # GET /dish_choices/1.json
  def show
  end

  # GET /dish_choices/new
  def new
    @dish_choice = @store.dish_choices.build
  end

  # GET /dish_choices/1/edit
  def edit
  end

  # POST /dish_choices
  # POST /dish_choices.json
  def create
    @dish_choice = @store.dish_choices.build(dish_choice_params)

    respond_to do |format|
      if @dish_choice.save
        format.html { redirect_to store_dish_choices_url(@store), notice: 'Dish choice was successfully created.' }
        format.json { render action: 'show', status: :created, location: @dish_choice }
      else
        format.html { render action: 'new' }
        format.json { render json: @dish_choice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dish_choices/1
  # PATCH/PUT /dish_choices/1.json
  def update
    respond_to do |format|
      if @dish_choice.update(dish_choice_params)
        format.html { redirect_to store_dish_choices_url(@store), notice: 'Dish choice was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @dish_choice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dish_choices/1
  # DELETE /dish_choices/1.json
  def destroy
    @dish_choice.destroy
    respond_to do |format|
      format.html { redirect_to store_dish_choices_url(@store) }
      format.json { head :no_content }
    end
  end

  private
    def set_store
      @store = Store.find(params[:store_id])
      @cartridge_array = @store.get_cartridge_array
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_dish_choice
      @dish_choice = DishChoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dish_choice_params
      params.require(:dish_choice).permit(:name, :bei, :content, :input_type, :must, :store_id, :checked)
    end
end
