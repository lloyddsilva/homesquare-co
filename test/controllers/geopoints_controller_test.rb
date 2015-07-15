require 'test_helper'

class GeopointsControllerTest < ActionController::TestCase
  setup do
    @geopoint = geopoints(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:geopoints)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create geopoint" do
    assert_difference('Geopoint.count') do
      post :create, geopoint: { address: @geopoint.address, block_number: @geopoint.block_number, latitude: @geopoint.latitude, longitude: @geopoint.longitude, postal_code: @geopoint.postal_code, street_name: @geopoint.street_name }
    end

    assert_redirected_to geopoint_path(assigns(:geopoint))
  end

  test "should show geopoint" do
    get :show, id: @geopoint
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @geopoint
    assert_response :success
  end

  test "should update geopoint" do
    patch :update, id: @geopoint, geopoint: { address: @geopoint.address, block_number: @geopoint.block_number, latitude: @geopoint.latitude, longitude: @geopoint.longitude, postal_code: @geopoint.postal_code, street_name: @geopoint.street_name }
    assert_redirected_to geopoint_path(assigns(:geopoint))
  end

  test "should destroy geopoint" do
    assert_difference('Geopoint.count', -1) do
      delete :destroy, id: @geopoint
    end

    assert_redirected_to geopoints_path
  end
end
