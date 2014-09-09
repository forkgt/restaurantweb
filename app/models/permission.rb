class Permission
  def initialize(admin)
    allow_all
    #
    # allow :q, [:index, :features, :examples, :pricing, :store_home, :store_menus, :store_map, :store_intro, :store_message,
    #           :order_paypal_notify, :statement_paypal_notify, :check_address, :reset_address]
    #
    # allow :users, []
    # allow :admins, []
    #
    # if admin
    #   allow :stores, :index
    #   allow :stores, [:show, :edit, :create, :destroy] do |store|
    #     store.admin_id == admin.id
    #   end
    #
    #   if admin.feng?
    #     allow :stores, [:show, :edit, :create, :destroy]
    #   end
    # end
  end

  def allow?(controller, action, resource = nil)
    allowed = @allow_all || @allowed_actions[[controller.to_s, action.to_s]]
    allowed && (allowed == true || resource && allowed.call(resource))
  end

  def allow_all
    @allow_all = true
  end

  def allow(controllers, actions, &block)
    @allowed_actions ||= {}
    Array(controllers).each do |controller|
      Array(actions).each do |action|
        @allowed_actions[[controller.to_s, action.to_s]] = block || true
      end
    end
  end
end