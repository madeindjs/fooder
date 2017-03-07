require 'test_helper'

class DishesControllerTest < ActionDispatch::IntegrationTest


  setup do
    @dish = dishes(:one)
    @restaurant = restaurants(:one)
    # host! "example.com" 
  end

  test "should get index" do
    # get dishes_url
    get dishes_url
    assert_response :success
  end

  test "should get new" do
    login(users(:me))
    get new_dish_path
    assert_response :success
  end

  test "should redirect on get new" do
    get new_dish_url
    assert_response 302
  end

  test "should create dish" do
    login(users(:me))
    assert_difference('Dish.count') do
      post dishes_url, params: { dish: { category_id: @dish.category_id, description: @dish.description, name: @dish.name, restaurant_id: @dish.restaurant_id, user_id: @dish.user_id } }
    end

    assert_redirected_to Dish.last
  end

  test "should not create dish" do
    assert_no_difference('Dish.count') do
      post dishes_url, params: { dish: { category_id: @dish.category_id, description: @dish.description, name: @dish.name, restaurant_id: @dish.restaurant_id, user_id: @dish.user_id } }
    end

    assert_redirected_to @restaurant
  end

  test "should show dish" do
    get dish_url(@dish)
  end

  test "should redirect on get edit" do
    get edit_dish_url @dish
    assert_response 302
  end

  test "should get edit" do
    login(users(:me))
    get edit_dish_url(@dish)
    assert_response :success
  end

  test "should not update dish" do
    patch dish_url(@dish), params: { dish: { category_id: @dish.category_id, description: @dish.description, name: @dish.name, restaurant_id: @dish.restaurant_id, user_id: @dish.user_id } }
    assert_redirected_to restaurant_url(@restaurant)
  end

  test "should update dish" do
    login(users(:me))
    patch dish_url(@dish), params: { dish: { category_id: @dish.category_id, description: @dish.description, name: @dish.name, restaurant_id: @dish.restaurant_id, user_id: @dish.user_id } }
    assert_redirected_to dish_url(@dish)
  end

  test "should not destroy dish" do
    assert_no_difference('Dish.count') do
      delete dish_url(@dish)
    end

    assert_redirected_to restaurant_url(@restaurant)
  end

  test "should destroy dish" do
    login(users(:me))
    assert_difference('Dish.count', -1) do
      delete dish_url(@dish)
    end

    assert_redirected_to restaurant_url(@dish.restaurant)
  end
end
