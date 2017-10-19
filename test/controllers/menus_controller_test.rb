require 'test_helper'

class MenusControllerTest < ActionDispatch::IntegrationTest
  setup do
    @menu = menus(:one)
    @restaurant = restaurants(:one)
    setup_restaurant_host
  end


  test "should redirect on get new" do
    get new_menu_url
    assert_response :forbidden
  end

  test "should get new" do
    login users(:me)
    get new_menu_url
    assert_response :success
  end

  test "should redirect on create menu" do
    assert_no_difference('Menu.count') do
      post menus_url, params: { menu: { content: @menu.content, description: @menu.description, name: @menu.name, price: @menu.price, restaurant_id: @menu.restaurant_id, tags: @menu.tags, user_id: @menu.user_id } }
    end
    assert_response :forbidden
  end

  test "should create menu" do
    login users(:me)
    assert_difference('Menu.count') do
      post menus_url, params: { menu: { content: @menu.content, description: @menu.description, name: @menu.name, price: @menu.price, restaurant_id: @menu.restaurant_id, tags: @menu.tags, user_id: @menu.user_id } }
    end
    assert_response :success
  end

  test "should get edit" do
    login users(:me)
    get edit_menu_url(@menu)
    assert_response :success
  end

  test "should redirect on get edit" do
    get edit_menu_url(@menu)
    assert_response :forbidden
  end

  test "should redirect on update menu" do
    patch menu_url(@menu), params: { menu: { content: @menu.content, description: @menu.description, name: @menu.name, price: @menu.price, restaurant_id: @menu.restaurant_id, tags: @menu.tags, user_id: @menu.user_id } }
    assert_response :forbidden
  end

  test "should update menu" do
    login users(:me)
    patch menu_url(@menu), params: { menu: { content: @menu.content, description: @menu.description, name: @menu.name, price: @menu.price, restaurant_id: @menu.restaurant_id, tags: @menu.tags, user_id: @menu.user_id } }
    assert_response :success
  end

  test "should redirect on destroy menu" do
    assert_no_difference('Menu.count') do
      delete menu_url(@menu)
    end
    assert_response :forbidden
  end

  test "should destroy menu" do
    login users(:me)
    assert_difference('Menu.count', -1) do
      delete menu_url(@menu)
    end
    assert_response :success
  end
end
