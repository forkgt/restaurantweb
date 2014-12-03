class Admins::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  # GET /resource/sign_up
  def new
    build_resource({})

    # if admin has_many stores
    #resource.stores.build

    # if admin has_one store
    resource.build_store

    respond_with self.resource
  end

  def create
    super
    #puts "=================================================="
    #puts sign_up_params
    #puts "=================================================="
  end

  def edit
    @store = resource.store
    # unless @store.nil?
    #   @cartridge_array = @store.get_cartridge_array
    # end

    super
  end

  def update
    @store = resource.store
    # unless @store.nil?
    #   @cartridge_array = @store.get_cartridge_array
    # end

    super
  end

  private

  def configure_permitted_parameters
    # if admin has_many stores
    #devise_parameter_sanitizer.for(:sign_up) << { stores_attributes: [:name, :bei, :phone, :fax] }

    # if admin has_one store
    #devise_parameter_sanitizer.for(:sign_up) << { store_attributes: [:name, :bei, :phone, :fax] }

    devise_parameter_sanitizer.for(:sign_up) << [:firstname, :lastname, :phone]
  end
end