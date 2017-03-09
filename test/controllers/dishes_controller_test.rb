require 'test_helper'

class DishesControllerTest < ActionDispatch::IntegrationTest


  setup do
    @dish = dishes(:one)
    @restaurant = restaurants(:one)
  end

  test "should get index" do
    setup_restaurant_host
    get dishes_url
    assert_response :success
  end


  test "should redirect get index at pages#home" do
    get dishes_url
    assert_redirected_to home_url(subdomain: '')
  end


  test "should get new" do
    setup_restaurant_host
    login(users(:me))
    get new_dish_path
    assert_response :success
  end

  test "should redirect get new on restaurant page" do
    get new_dish_url
    assert_response 302
  end


  test "should create dish" do
    setup_restaurant_host
    login(users(:me))
    assert_difference('Dish.count') do
      post dishes_url, params: { dish: { category_id: @dish.category_id, description: @dish.description, name: @dish.name, restaurant_id: @dish.restaurant_id, user_id: @dish.user_id } }
    end

    assert_redirected_to Dish.last
  end

  test "should not create dish" do
    setup_restaurant_host
    assert_no_difference('Dish.count') do
      post dishes_url, params: { dish: { category_id: @dish.category_id, description: @dish.description, name: @dish.name, restaurant_id: @dish.restaurant_id, user_id: @dish.user_id } }
    end

    assert_redirected_to root_path
  end

  test "should show dish" do
    setup_restaurant_host
    get dish_url(@dish)
  end

  test "should redirect on get edit" do
    setup_restaurant_host
    get edit_dish_url @dish
    assert_response 302
  end

  test "should get edit" do
    setup_restaurant_host
    login(users(:me))
    get edit_dish_url(@dish)
    assert_response :success
  end

  test "should not update dish" do
    setup_restaurant_host
    patch dish_url(@dish), params: { dish: { category_id: @dish.category_id, description: @dish.description, name: @dish.name, restaurant_id: @dish.restaurant_id, user_id: @dish.user_id } }
    assert_redirected_to root_path
  end

  test "should update dish" do
    setup_restaurant_host
    login(users(:me))
    patch dish_url(@dish), params: { dish: { category_id: @dish.category_id, description: @dish.description, name: @dish.name, restaurant_id: @dish.restaurant_id, user_id: @dish.user_id } }
    assert_redirected_to dish_url(@dish)
  end

  test "should not destroy dish" do
    setup_restaurant_host
    assert_no_difference('Dish.count') do
      delete dish_url(@dish)
    end

    assert_redirected_to root_path
  end

  test "should destroy dish" do
    setup_restaurant_host
    login(users(:me))
    assert_difference('Dish.count', -1) do
      delete dish_url(@dish)
    end

    assert_redirected_to dishes_url
  end
end
