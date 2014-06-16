require 'test_helper'

class CartridgesControllerTest < ActionController::TestCase
  setup do
    @cartridge = cartridges(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cartridges)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cartridge" do
    assert_difference('Cartridge.count') do
      post :create, cartridge: { bei: @cartridge.bei, image: @cartridge.image, interval: @cartridge.interval, name: @cartridge.name, price: @cartridge.price, rank: @cartridge.rank }
    end

    assert_redirected_to cartridge_path(assigns(:cartridge))
  end

  test "should show cartridge" do
    get :show, id: @cartridge
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cartridge
    assert_response :success
  end

  test "should update cartridge" do
    patch :update, id: @cartridge, cartridge: { bei: @cartridge.bei, image: @cartridge.image, interval: @cartridge.interval, name: @cartridge.name, price: @cartridge.price, rank: @cartridge.rank }
    assert_redirected_to cartridge_path(assigns(:cartridge))
  end

  test "should destroy cartridge" do
    assert_difference('Cartridge.count', -1) do
      delete :destroy, id: @cartridge
    end

    assert_redirected_to cartridges_path
  end
end
