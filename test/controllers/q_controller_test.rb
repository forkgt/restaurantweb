require 'test_helper'

class QControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get stores" do
    get :stores
    assert_response :success
  end

  test "should get store" do
    get :store
    assert_response :success
  end

end
