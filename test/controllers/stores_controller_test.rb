require 'test_helper'

class StoresControllerTest < ActionController::TestCase
  setup do
    @store = stores(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create store" do
    assert_difference('Store.count') do
      post :create, store: { admin_id: @store.admin_id, avatar: @store.avatar, delivery_fee: @store.delivery_fee, delivery_minimum: @store.delivery_minimum, delivery_radius: @store.delivery_radius, desc: @store.desc, fax: @store.fax, name: @store.name, phone: @store.phone, rank: @store.rank }
    end

    assert_redirected_to store_path(assigns(:store))
  end

  test "should show store" do
    get :show, id: @store
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @store
    assert_response :success
  end

  test "should update store" do
    patch :update, id: @store, store: { admin_id: @store.admin_id, avatar: @store.avatar, delivery_fee: @store.delivery_fee, delivery_minimum: @store.delivery_minimum, delivery_radius: @store.delivery_radius, desc: @store.desc, fax: @store.fax, name: @store.name, phone: @store.phone, rank: @store.rank }
    assert_redirected_to store_path(assigns(:store))
  end

  test "should destroy store" do
    assert_difference('Store.count', -1) do
      delete :destroy, id: @store
    end

    assert_redirected_to stores_path
  end
end
