class Admins::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  # GET /resource/sign_up
  def new
    build_resource({})
    resource.stores.build
    respond_with self.resource
  end

  def create
    super
    #puts "=================================================="
    #puts sign_up_params
    #puts "=================================================="
  end

  def edit
    @store = resource.stores.first
    super
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << { stores_attributes: [:name, :bei, :phone, :fax] }
  end
end