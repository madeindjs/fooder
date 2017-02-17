require 'test_helper'
require "authlogic/test_case"

class DishesControllerTest < ActionDispatch::IntegrationTest

  setup :activate_authlogic

  setup do
    @dish = dishes(:one)
  end

  test "should get index" do
    get dishes_url
    assert_response :success
  end

  test "should get new" do
    UserSession.create(users(:me))
    get new_dish_url
    assert_response :success
  end

  test "should redirect on get new" do
    get new_dish_url
    assert_response 302
  end

  test "should create dish" do
    assert_difference('Dish.count') do
      post dishes_url, params: { dish: { category_id: @dish.category_id, description: @dish.description, name: @dish.name, restaurant_id: @dish.restaurant_id, user_id: @dish.user_id } }
    end

    assert_redirected_to dish_url(Dish.last)
  end

  test "should not create dish" do
    assert_no_difference('Dish.count') do
      post dishes_url, params: { dish: { category_id: @dish.category_id, description: @dish.description, name: @dish.name, restaurant_id: @dish.restaurant_id, user_id: @dish.user_id } }
    end

    assert_redirected_to home_path
  end

  test "should show dish" do
    get dish_url(@dish)
    assert_response :success
  end

  test "should redirect on get edit" do
    get edit_dish_url(@dish)
    assert_response 302
  end

  test "should get edit" do
    UserSession.create(@dish.user)
    get edit_dish_url(@dish)
    assert_response :success
  end

  test "should redirect on update dish" do
    patch dish_url(@dish), params: { dish: { category_id: @dish.category_id, description: @dish.description, name: @dish.name, restaurant_id: @dish.restaurant_id, user_id: @dish.user_id } }
    assert_redirected_to home_path
  end

  test "should not update dish" do
    patch dish_url(@dish), params: { dish: { category_id: @dish.category_id, description: @dish.description, name: @dish.name, restaurant_id: @dish.restaurant_id, user_id: @dish.user_id } }
    assert_redirected_to home_path
  end

  test "should update dish" do
    UserSession.create(@dish.user)
    patch dish_url(@dish), params: { dish: { category_id: @dish.category_id, description: @dish.description, name: @dish.name, restaurant_id: @dish.restaurant_id, user_id: @dish.user_id } }
    assert_redirected_to dish_url(@dish)
  end

  test "should not destroy dish" do
    assert_no_difference('Dish.count') do
      delete dish_url(@dish)
    end

    assert_redirected_to home_path
  end

  test "should destroy dish" do
    UserSession.create(users(:me))
    assert_difference('Dish.count', -1) do
      delete dish_url(@dish)
    end

    assert_redirected_to dishes_url
  end
end
