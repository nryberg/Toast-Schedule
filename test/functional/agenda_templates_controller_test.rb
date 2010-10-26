require 'test_helper'

class AgendaTemplatesControllerTest < ActionController::TestCase
  setup do
    @agenda_template = agenda_templates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:agenda_templates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create agenda_template" do
    assert_difference('AgendaTemplate.count') do
      post :create, :agenda_template => @agenda_template.attributes
    end

    assert_redirected_to agenda_template_path(assigns(:agenda_template))
  end

  test "should show agenda_template" do
    get :show, :id => @agenda_template.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @agenda_template.to_param
    assert_response :success
  end

  test "should update agenda_template" do
    put :update, :id => @agenda_template.to_param, :agenda_template => @agenda_template.attributes
    assert_redirected_to agenda_template_path(assigns(:agenda_template))
  end

  test "should destroy agenda_template" do
    assert_difference('AgendaTemplate.count', -1) do
      delete :destroy, :id => @agenda_template.to_param
    end

    assert_redirected_to agenda_templates_path
  end
end
