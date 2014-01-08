require 'test_helper'

class TemplatesControllerTest < ActionController::TestCase
  setup do
    @template = templates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:templates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create templates" do
    assert_difference('Template.count') do
      post :create, templates: { avatar: @template.avatar, desc: @template.desc, interval: @template.interval, name: @template.name, price: @template.price, rank: @template.rank }
    end

    assert_redirected_to template_path(assigns(:templates))
  end

  test "should show templates" do
    get :show, id: @template
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @template
    assert_response :success
  end

  test "should update templates" do
    patch :update, id: @template, templates: { avatar: @template.avatar, desc: @template.desc, interval: @template.interval, name: @template.name, price: @template.price, rank: @template.rank }
    assert_redirected_to template_path(assigns(:templates))
  end

  test "should destroy templates" do
    assert_difference('Template.count', -1) do
      delete :destroy, id: @template
    end

    assert_redirected_to templates_path
  end
end
