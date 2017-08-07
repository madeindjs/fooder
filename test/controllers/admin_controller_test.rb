require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest

  test "should get categories" do
    setup_restaurant_host
    login(users(:me))
    get admin_categories_url
    assert_response :success
  end

  test "should get dishes" do
    setup_restaurant_host
    login(users(:me))
    get admin_dishes_path
    assert_response :success
  end

  test "should get menus" do
    setup_restaurant_host
    login(users(:me))
    get admin_menus_url
    assert_response :success
  end

  test "should get opening_hours" do
    setup_restaurant_host
    login(users(:me))
    get admin_opening_hours_url
    assert_response :success
  end

  test "should get sections" do
    setup_restaurant_host
    login(users(:me))
    get admin_sections_url
    assert_response :success
  end

end
