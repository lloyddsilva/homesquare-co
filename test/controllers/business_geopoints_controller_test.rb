require 'test_helper'

class BusinessGeopointsControllerTest < ActionController::TestCase
  setup do
    @business_geopoint = business_geopoints(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:business_geopoints)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create business_geopoint" do
    assert_difference('BusinessGeopoint.count') do
      post :create, business_geopoint: { business_id: @business_geopoint.business_id, geopoint_id: @business_geopoint.geopoint_id }
    end

    assert_redirected_to business_geopoint_path(assigns(:business_geopoint))
  end

  test "should show business_geopoint" do
    get :show, id: @business_geopoint
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @business_geopoint
    assert_response :success
  end

  test "should update business_geopoint" do
    patch :update, id: @business_geopoint, business_geopoint: { business_id: @business_geopoint.business_id, geopoint_id: @business_geopoint.geopoint_id }
    assert_redirected_to business_geopoint_path(assigns(:business_geopoint))
  end

  test "should destroy business_geopoint" do
    assert_difference('BusinessGeopoint.count', -1) do
      delete :destroy, id: @business_geopoint
    end

    assert_redirected_to business_geopoints_path
  end
end
