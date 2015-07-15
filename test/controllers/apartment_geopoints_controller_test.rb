require 'test_helper'

class ApartmentGeopointsControllerTest < ActionController::TestCase
  setup do
    @apartment_geopoint = apartment_geopoints(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:apartment_geopoints)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create apartment_geopoint" do
    assert_difference('ApartmentGeopoint.count') do
      post :create, apartment_geopoint: { apartment_id: @apartment_geopoint.apartment_id, geopoint_id: @apartment_geopoint.geopoint_id }
    end

    assert_redirected_to apartment_geopoint_path(assigns(:apartment_geopoint))
  end

  test "should show apartment_geopoint" do
    get :show, id: @apartment_geopoint
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @apartment_geopoint
    assert_response :success
  end

  test "should update apartment_geopoint" do
    patch :update, id: @apartment_geopoint, apartment_geopoint: { apartment_id: @apartment_geopoint.apartment_id, geopoint_id: @apartment_geopoint.geopoint_id }
    assert_redirected_to apartment_geopoint_path(assigns(:apartment_geopoint))
  end

  test "should destroy apartment_geopoint" do
    assert_difference('ApartmentGeopoint.count', -1) do
      delete :destroy, id: @apartment_geopoint
    end

    assert_redirected_to apartment_geopoints_path
  end
end
