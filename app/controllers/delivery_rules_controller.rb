class DeliveryRulesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_store
  before_action :set_delivery_rule, only: [:show, :edit, :update, :destroy]

  # GET /delivery_rules
  # GET /delivery_rules.json
  def index
    @delivery_rules = @store.delivery_rules
  end

  # GET /delivery_rules/1
  # GET /delivery_rules/1.json
  def show
  end

  # GET /delivery_rules/new
  def new
    @delivery_rule = @store.delivery_rules.build
  end

  # GET /delivery_rules/1/edit
  def edit
  end

  # POST /delivery_rules
  # POST /delivery_rules.json
  def create
    @delivery_rule = @store.delivery_rules.build(delivery_rule_params)

    respond_to do |format|
      if @delivery_rule.save
        format.html { redirect_to store_delivery_rules_url(@store), notice: 'Delivery rule was successfully created.' }
        format.json { render action: 'show', status: :created, location: @delivery_rule }
      else
        format.html { render action: 'new' }
        format.json { render json: @delivery_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /delivery_rules/1
  # PATCH/PUT /delivery_rules/1.json
  def update
    respond_to do |format|
      if @delivery_rule.update(delivery_rule_params)
        format.html { redirect_to store_delivery_rules_url(@store), notice: 'Delivery rule was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @delivery_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /delivery_rules/1
  # DELETE /delivery_rules/1.json
  def destroy
    @delivery_rule.destroy
    respond_to do |format|
      format.html { redirect_to store_delivery_rules_url(@store) }
      format.json { head :no_content }
    end
  end

  private
    def set_store
      @store = Store.find(params[:store_id])
      @cartridge_array = @store.get_cartridge_array
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_delivery_rule
      @delivery_rule = DeliveryRule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def delivery_rule_params
      params.require(:delivery_rule).permit(:name, :bei, :rank, :delivery_fee, :delivery_minimum, :delivery_radius, :store_id)
    end
end
