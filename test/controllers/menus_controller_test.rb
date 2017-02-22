require 'test_helper'

class MenusControllerTest < ActionDispatch::IntegrationTest
  setup do
    @menu = menus(:one)
    @restaurant = restaurants(:one)
  end

  test "should get index" do
    get restaurant_menus_url(@restaurant)
    assert_response :success
  end

  test "should redirect on get new" do
    get new_restaurant_menu_url(@restaurant)
    assert_response 302
  end

  test "should get new" do
    login users(:me)
    get new_restaurant_menu_url(@restaurant)
    assert_response :success
  end

  test "should redirect on create menu" do
    assert_no_difference('Menu.count') do
      post restaurant_menus_url(@restaurant), params: { menu: { content: @menu.content, description: @menu.description, name: @menu.name, price: @menu.price, restaurant_id: @menu.restaurant_id, tags: @menu.tags, user_id: @menu.user_id } }
    end

    assert_redirected_to restaurant_url(@restaurant)
  end

  test "should create menu" do
    login users(:me)
    assert_difference('Menu.count') do
      post restaurant_menus_url(@restaurant), params: { menu: { content: @menu.content, description: @menu.description, name: @menu.name, price: @menu.price, restaurant_id: @menu.restaurant_id, tags: @menu.tags, user_id: @menu.user_id } }
    end

    assert_redirected_to restaurant_menu_url(@restaurant, Menu.last)
  end

  test "should show menu" do
    get restaurant_menu_url(@restaurant,@menu)
    assert_response :success
  end

  test "should get edit" do
    login users(:me)
    get edit_restaurant_menu_url(@restaurant,@menu)
    assert_response :success
  end

  test "should redirect on get edit" do
    get edit_restaurant_menu_url(@restaurant,@menu)
    assert_response 302
  end

  test "should redirect on update menu" do
    patch restaurant_menu_url(@restaurant,@menu), params: { menu: { content: @menu.content, description: @menu.description, name: @menu.name, price: @menu.price, restaurant_id: @menu.restaurant_id, tags: @menu.tags, user_id: @menu.user_id } }
    assert_redirected_to restaurant_url(@restaurant)
  end

  test "should update menu" do
    login users(:me)
    patch restaurant_menu_url(@restaurant,@menu), params: { menu: { content: @menu.content, description: @menu.description, name: @menu.name, price: @menu.price, restaurant_id: @menu.restaurant_id, tags: @menu.tags, user_id: @menu.user_id } }
    assert_redirected_to restaurant_menu_url(@restaurant,@menu)
  end

  test "should redirect on destroy menu" do
    assert_no_difference('Menu.count') do
      delete restaurant_menu_url(@restaurant,@menu)
    end

    assert_redirected_to restaurant_url(@restaurant)
  end

  test "should destroy menu" do
    login users(:me)
    assert_difference('Menu.count', -1) do
      delete restaurant_menu_url(@restaurant,@menu)
    end

    assert_redirected_to restaurant_menus_url(@restaurant)
  end
end
