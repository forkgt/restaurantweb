require 'test_helper'

class StatementsControllerTest < ActionController::TestCase
  setup do
    @statement = statements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:statements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create statement" do
    assert_difference('Statement.count') do
      post :create, statement: { invoice: @statement.invoice, month: @statement.month, payment_status: @statement.payment_status, payment_type: @statement.payment_type, store_id: @statement.store_id, year: @statement.year }
    end

    assert_redirected_to statement_path(assigns(:statement))
  end

  test "should show statement" do
    get :show, id: @statement
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @statement
    assert_response :success
  end

  test "should update statement" do
    patch :update, id: @statement, statement: { invoice: @statement.invoice, month: @statement.month, payment_status: @statement.payment_status, payment_type: @statement.payment_type, store_id: @statement.store_id, year: @statement.year }
    assert_redirected_to statement_path(assigns(:statement))
  end

  test "should destroy statement" do
    assert_difference('Statement.count', -1) do
      delete :destroy, id: @statement
    end

    assert_redirected_to statements_path
  end
end
