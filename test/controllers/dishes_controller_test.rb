require 'test_helper'


class DishesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @dish = dishes(:one)
  end

  test "should get index" do
    get restaurant_dishes_url(restaurant_id: 1)
    assert_response :success
  end

  test "should get new" do
    login(users(:me))
    get new_restaurant_dish_url(restaurant_id: 1)
    assert_response :success
  end

  test "should redirect on get new" do
    get new_restaurant_dish_url(restaurant_id: 1)
    assert_response 302
  end

  test "should create dish" do
    login(users(:me))
    assert_difference('Dish.count') do
      post restaurant_dishes_url(restaurant_id: 1), params: { dish: { category_id: @dish.category_id, description: @dish.description, name: @dish.name, restaurant_id: @dish.restaurant_id, user_id: @dish.user_id } }
    end

    assert_redirected_to restaurant_dish_url(Dish.last, restaurant_id: Dish.last.restaurant_id)
  end

  test "should not create dish" do
    assert_no_difference('Dish.count') do
      post restaurant_dishes_url(restaurant_id: 1), params: { dish: { category_id: @dish.category_id, description: @dish.description, name: @dish.name, restaurant_id: @dish.restaurant_id, user_id: @dish.user_id } }
    end

    assert_redirected_to home_path
  end

  test "should show dish" do
    get restaurant_dish_url(@dish, restaurant_id: 1)
  end

  test "should redirect on get edit" do
    get edit_restaurant_dish_url(@dish, restaurant_id: @dish.restaurant_id)
    assert_response 302
  end

  test "should get edit" do
    login(users(:me))
    get edit_restaurant_dish_url(@dish, restaurant_id: @dish.restaurant_id)
    assert_response :success
  end

  test "should not update dish" do
    patch restaurant_dish_url(@dish, restaurant_id: 1), params: { dish: { category_id: @dish.category_id, description: @dish.description, name: @dish.name, restaurant_id: @dish.restaurant_id, user_id: @dish.user_id } }
    assert_redirected_to home_path
  end

  test "should update dish" do
    login(users(:me))
    patch restaurant_dish_url(@dish, restaurant_id: 1), params: { dish: { category_id: @dish.category_id, description: @dish.description, name: @dish.name, restaurant_id: @dish.restaurant_id, user_id: @dish.user_id } }
    assert_redirected_to restaurant_dish_url(Dish.last, restaurant_id: Dish.last.restaurant_id)
  end

  test "should not destroy dish" do
    assert_no_difference('Dish.count') do
      delete restaurant_dish_url(@dish, restaurant_id: @dish.restaurant_id)
    end

    assert_redirected_to home_path
  end

  test "should destroy dish" do
    login(users(:me))
    assert_difference('Dish.count', -1) do
      delete restaurant_dish_url(@dish, restaurant_id: @dish.restaurant_id)
    end

    assert_redirected_to restaurant_url(@dish.restaurant)
  end
end
