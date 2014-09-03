class StatementsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_store
  before_action :set_statement, only: [:show, :edit, :update, :destroy]

  # GET /statements
  # GET /statements.json
  def index
    @statements = @store.statements
    @not_paid_count = Statement.where(:payment_status => "not_paid").count
  end

  # GET /statements/1
  # GET /statements/1.json
  def show
  end

  # GET /statements/new
  def new
    @statement = @store.statements.build
  end

  # GET /statements/1/edit
  def edit
  end

  # POST /statements
  # POST /statements.json
  def create
    @statement = @store.statements.build(statement_params)

    y = statement_params[:year].to_i
    m = statement_params[:month].to_i
    os = Statement.find_by_year_and_month_and_store_id(y, m, @store.id)

    respond_to do |format|
      if os.nil? && @statement.save
        # Calculate Fax Fee
        b = Time.new(y, m)
        (1 .. Time.days_in_month(m, y)).each do |n|
          c = Order.where(:created_at => b + (n-1).days .. b + n.days, store_id: @store.id).count
          @statement.statement_items.create(day: n, price: 0.1, quantity: c, note: "good", name: "fax") if c > 0
        end

        # Calculate Subscription Fee
        @store.subscriptions.each do |subscription|
          @statement.statement_items.create(day: 1, price: subscription.subscribable.price, quantity: 1, note: "hello", name: subscription.subscribable.name)
        end

        format.html { redirect_to store_statements_url(@store), notice: 'Statement was successfully created.' }
        format.json { render action: 'show', status: :created, location: @statement }
      else
        format.html { render action: 'new' }
        format.json { render json: @statement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statements/1
  # PATCH/PUT /statements/1.json
  def update
    respond_to do |format|
      if @statement.update(statement_params)
        format.html { redirect_to store_statements_url(@store), notice: 'Statement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @statement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statements/1
  # DELETE /statements/1.json
  def destroy
    @statement.destroy
    respond_to do |format|
      format.html { redirect_to store_statements_url(@store) }
      format.json { head :no_content }
    end
  end

  private
    def set_store
      @store = Store.find(params[:store_id])
      @cartridge_array = @store.get_cartridge_array
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_statement
      @statement = Statement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def statement_params
      params.require(:statement).permit(:year, :month, :payment_type, :payment_status, :invoice, :store_id)
    end
end
