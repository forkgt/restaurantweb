require 'test_helper'

class DeliveryRulesControllerTest < ActionController::TestCase
  setup do
    @delivery_rule = delivery_rules(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:delivery_rules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create delivery_rule" do
    assert_difference('DeliveryRule.count') do
      post :create, delivery_rule: { bei: @delivery_rule.bei, delivery_fee: @delivery_rule.delivery_fee, delivery_minimum: @delivery_rule.delivery_minimum, delivery_radius: @delivery_rule.delivery_radius, name: @delivery_rule.name, rank: @delivery_rule.rank, store_id: @delivery_rule.store_id }
    end

    assert_redirected_to delivery_rule_path(assigns(:delivery_rule))
  end

  test "should show delivery_rule" do
    get :show, id: @delivery_rule
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @delivery_rule
    assert_response :success
  end

  test "should update delivery_rule" do
    patch :update, id: @delivery_rule, delivery_rule: { bei: @delivery_rule.bei, delivery_fee: @delivery_rule.delivery_fee, delivery_minimum: @delivery_rule.delivery_minimum, delivery_radius: @delivery_rule.delivery_radius, name: @delivery_rule.name, rank: @delivery_rule.rank, store_id: @delivery_rule.store_id }
    assert_redirected_to delivery_rule_path(assigns(:delivery_rule))
  end

  test "should destroy delivery_rule" do
    assert_difference('DeliveryRule.count', -1) do
      delete :destroy, id: @delivery_rule
    end

    assert_redirected_to delivery_rules_path
  end
end
