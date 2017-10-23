require 'test_helper'

class DishesControllerTest < ActionDispatch::IntegrationTest


  setup do
    @dish = dishes(:one)
    @restaurant = restaurants(:one)
  end

  test "should get new" do
    setup_restaurant_host
    login(users(:me))
    get new_dish_path
    assert_response :success
  end

  test "should redirect get new on restaurant page" do
    get new_dish_url
    assert_response :forbidden
  end

  test "should get import" do
    setup_restaurant_host
    login(users(:me))
    get dishes_import_path
    assert_response :success
  end

  test "should import dishes" do
    setup_restaurant_host
    login(users(:me))
    assert_difference('Dish.count') do
      post dishes_import_path, params: {csv: 'Salade;une bonne salade;10;Entrée'}
    end
    assert_response :success
  end

  test "should import mutliples dishes" do
    setup_restaurant_host
    login(users(:me))
    assert_difference('Dish.count', 2) do
      post dishes_import_path, params: {csv: "Salade;une bonne salade;10;Entrée\nTourte;une bonne tourte;10;Entrée"}
    end
    assert_response :success
  end


  test "should import dishes & create actegory" do
    setup_restaurant_host
    login(users(:me))
    assert_difference('Category.count') do
      post dishes_import_path, params: {csv: 'Salade;une bonne salade;10;Une nouvelle catégorie qui n\'existe pas'}
    end
    assert_response :success
  end


  test "should create dish" do
    setup_restaurant_host
    login(users(:me))
    assert_difference('Dish.count') do
      post dishes_url, params: { dish: { category_id: @dish.category_id, description: @dish.description, name: @dish.name, restaurant_id: @dish.restaurant_id, user_id: @dish.user_id, price: 1 } }
    end
    assert_response :success
  end


  test "should create category" do
    setup_restaurant_host
    login(users(:me))
    assert_difference('Category.count') do
      post dishes_url, params: { dish: { description: @dish.description, name: @dish.name, restaurant_id: @dish.restaurant_id, user_id: @dish.user_id, price: 1 }, category: {name: 'New category name'} }
    end
    assert_response :success
  end

  test "should not create dish" do
    setup_restaurant_host
    assert_no_difference('Dish.count') do
      post dishes_url, params: { dish: { category_id: @dish.category_id, description: @dish.description, name: @dish.name, restaurant_id: @dish.restaurant_id, user_id: @dish.user_id, price: 1 } }
    end
    assert_response :forbidden
  end

  test "should redirect on get edit" do
    setup_restaurant_host
    get edit_dish_url @dish
    assert_response :forbidden
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
    assert_response :forbidden
  end

  test "should update dish" do
    setup_restaurant_host
    login(users(:me))
    patch dish_url(@dish), params: { dish: { category_id: @dish.category_id, description: @dish.description, name: @dish.name, restaurant_id: @dish.restaurant_id, user_id: @dish.user_id } }
    assert_response :success
  end

  test "should not destroy dish" do
    setup_restaurant_host
    assert_no_difference('Dish.count') do
      delete dish_url(@dish)
    end
    assert_response :forbidden
  end

  test "should destroy dish" do
    setup_restaurant_host
    login(users(:me))
    assert_difference('Dish.count', -1) do
      delete dish_url(@dish)
    end
    assert_response :success
  end
end
