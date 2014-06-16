class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  def edit
    resource.build_address if resource.address.nil?
    @store = Store.find_by domain: request.host
    if @store.nil?
      redirect_to q_missing_path
      return
    else
      @template = @store.get_current_template
    end

  end


  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) << [:firstname, :lastname, :phone, :image,
                                                        { address_attributes: [:id, :address1, :address2, :city, :state, :country, :zip] }]
  end

end