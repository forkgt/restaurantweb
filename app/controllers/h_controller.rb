class HController < ApplicationController
  before_action :authenticate_admin!

  def user_manager
    @store = current_admin.store
    @cartridge_array = @store.get_cartridge_array
    @not_paid_count = Statement.where(:payment_status => "not_paid").count

    @users = @store.users
  end

  def retrieve_store
    @store = current_admin.store
    if @store
      redirect_to @store
    else
      uuid = params[:uuid]
      if uuid
        @store = Store.find_by_uuid(uuid)
        if @store.nil?
          flash[:alert] = "No such store"
        else
          current_admin.store = @store
          current_admin.save

          @cartridge_array = @store.get_cartridge_array

          redirect_to @store
        end
      end
    end
  end
end
