class Users::PasswordsController < Devise::PasswordsController

  before_action :set_store

  private
  def set_store
    @store = Store.find_by domain: request.host
    if @store.nil?
      redirect_to q_index_path
      return
    elsif @store.status == "closed"
      redirect_to q_store_message_path(message: "The store is currently close!")
      return
    else
      @template_name = get_store_template_name
    end
  end
end