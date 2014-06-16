class StatementItemsController < ApplicationController
  before_action :set_statement
  before_action :set_statement_item, only: [:show, :edit, :update, :destroy]

  # GET /statement_items
  # GET /statement_items.json
  def index
    @statement_items = @statement.statement_items
  end

  # GET /statement_items/1
  # GET /statement_items/1.json
  def show
  end

  # GET /statement_items/new
  def new
    @statement_item = @statement.statement_items.build
  end

  # GET /statement_items/1/edit
  def edit
  end

  # POST /statement_items
  # POST /statement_items.json
  def create
    @statement_item = @statement.statement_items.create(statement_item_params)

    respond_to do |format|
      if @statement_item.save
        format.html { redirect_to statement_statement_items_url(@statement), notice: 'Statement item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @statement_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @statement_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statement_items/1
  # PATCH/PUT /statement_items/1.json
  def update
    respond_to do |format|
      if @statement_item.update(statement_item_params)
        format.html { redirect_to statement_statement_items_url(@statement), notice: 'Statement item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @statement_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statement_items/1
  # DELETE /statement_items/1.json
  def destroy
    @statement_item.destroy
    respond_to do |format|
      format.html { redirect_to statement_statement_items_url(@statement) }
      format.json { head :no_content }
    end
  end

  private
    def set_statement
      @statement = Statement.find(params[:statement_id])
      @store = @statement.store
      @cartridge_array = @store.get_cartridge_array
    end

      # Use callbacks to share common setup or constraints between actions.
    def set_statement_item
      @statement_item = StatementItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def statement_item_params
      params.require(:statement_item).permit(:day, :name, :note, :price, :quantity, :statement_id)
    end
end
