require 'test_helper'

class MenusControllerTest < ActionDispatch::IntegrationTest
  setup do
    @menu = menus(:one)
  end

  test "should get index" do
    get menus_url
    assert_response :success
  end

  test "should get new" do
    get new_menu_url
    assert_response :success
  end

  test "should create menu" do
    assert_difference('Menu.count') do
      post menus_url, params: { menu: { content: @menu.content, description: @menu.description, name: @menu.name, price: @menu.price, restaurant_id: @menu.restaurant_id, tags: @menu.tags, user_id: @menu.user_id } }
    end

    assert_redirected_to menu_url(Menu.last)
  end

  test "should show menu" do
    get menu_url(@menu)
    assert_response :success
  end

  test "should get edit" do
    get edit_menu_url(@menu)
    assert_response :success
  end

  test "should update menu" do
    patch menu_url(@menu), params: { menu: { content: @menu.content, description: @menu.description, name: @menu.name, price: @menu.price, restaurant_id: @menu.restaurant_id, tags: @menu.tags, user_id: @menu.user_id } }
    assert_redirected_to menu_url(@menu)
  end

  test "should destroy menu" do
    assert_difference('Menu.count', -1) do
      delete menu_url(@menu)
    end

    assert_redirected_to menus_url
  end
end
