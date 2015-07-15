require 'test_helper'

class UserApartmentsControllerTest < ActionController::TestCase
  setup do
    @user_apartment = user_apartments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_apartments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_apartment" do
    assert_difference('UserApartment.count') do
      post :create, user_apartment: { apartment_id: @user_apartment.apartment_id, membership: @user_apartment.membership, status: @user_apartment.status, user_id: @user_apartment.user_id }
    end

    assert_redirected_to user_apartment_path(assigns(:user_apartment))
  end

  test "should show user_apartment" do
    get :show, id: @user_apartment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_apartment
    assert_response :success
  end

  test "should update user_apartment" do
    patch :update, id: @user_apartment, user_apartment: { apartment_id: @user_apartment.apartment_id, membership: @user_apartment.membership, status: @user_apartment.status, user_id: @user_apartment.user_id }
    assert_redirected_to user_apartment_path(assigns(:user_apartment))
  end

  test "should destroy user_apartment" do
    assert_difference('UserApartment.count', -1) do
      delete :destroy, id: @user_apartment
    end

    assert_redirected_to user_apartments_path
  end
end
