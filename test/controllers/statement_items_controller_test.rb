require 'test_helper'

class StatementItemsControllerTest < ActionController::TestCase
  setup do
    @statement_item = statement_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:statement_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create statement_item" do
    assert_difference('StatementItem.count') do
      post :create, statement_item: { day: @statement_item.day, name: @statement_item.name, note: @statement_item.note, price: @statement_item.price, quantity: @statement_item.quantity, statement_id: @statement_item.statement_id }
    end

    assert_redirected_to statement_item_path(assigns(:statement_item))
  end

  test "should show statement_item" do
    get :show, id: @statement_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @statement_item
    assert_response :success
  end

  test "should update statement_item" do
    patch :update, id: @statement_item, statement_item: { day: @statement_item.day, name: @statement_item.name, note: @statement_item.note, price: @statement_item.price, quantity: @statement_item.quantity, statement_id: @statement_item.statement_id }
    assert_redirected_to statement_item_path(assigns(:statement_item))
  end

  test "should destroy statement_item" do
    assert_difference('StatementItem.count', -1) do
      delete :destroy, id: @statement_item
    end

    assert_redirected_to statement_items_path
  end
end
