class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters
  before_action :set_store

  def edit
    resource.build_address if resource.address.nil?
  end

  def update
    @user = User.find(current_user.id)

    successfully_updated = if needs_password?(@user, params)
                             @user.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
                           else
                             # remove the virtual current_password attribute
                             # update_without_password doesn't know how to ignore it
                             params[:user].delete(:current_password)
                             @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
                           end

    if successfully_updated
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case their password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end

  private

  # check if we need password to update user data
  # ie if password or email was changed
  # extend this as needed
  def needs_password?(user, params)
    (params[:user][:email].present? && user.email != params[:user][:email]) || params[:user][:password].present?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) << [:firstname, :lastname, :phone, :image,
                                                        { address_attributes: [:id, :address1, :address2, :city, :state, :country, :zip] }]
    devise_parameter_sanitizer.for(:sign_up) << [:firstname, :lastname, :phone]
  end

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