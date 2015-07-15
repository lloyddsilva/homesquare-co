require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get privacy" do
    get :privacy
    assert_response :success
  end

  test "should get terms" do
    get :terms
    assert_response :success
  end

  test "should get faq" do
    get :faq
    assert_response :success
  end

  test "should get help" do
    get :help
    assert_response :success
  end

  test "should get careers" do
    get :careers
    assert_response :success
  end

  test "should get media" do
    get :media
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

  test "should get search" do
    get :search
    assert_response :success
  end

  test "should get populate" do
    get :populate
    assert_response :success
  end

end
