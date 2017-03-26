require 'test_helper'

class RestaurantsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @restaurant = restaurants(:one)
  end


  test "should get index" do
    get restaurants_url
    assert_response :success
  end

  test "should redirect on get new" do
    get new_restaurant_url
    assert_response 302
  end

  test "should get new" do
    login(users(:me))
    get new_restaurant_url
    assert_response :success
  end

  test "should not create restaurant" do
    assert_no_difference('Restaurant.count') do
      post restaurants_url, params: { restaurant: { address: @restaurant.address, city: @restaurant.city, name: @restaurant.name, zip_code: @restaurant.zip_code } }
    end

    assert_redirected_to root_path
  end

  test "should create restaurant" do
    login(users(:me))
    assert_difference('Restaurant.count') do
      post restaurants_url, params: { restaurant: { address: @restaurant.address, city: @restaurant.city, name: "new restaurant", zip_code: @restaurant.zip_code } }
    end

    assert_redirected_to root_url(subdomain: Restaurant.last)
  end

  test "should show restaurant" do
    get restaurant_url(@restaurant)
    assert_response :success
  end

  test "should get edit" do
    login(users(:me))
    get edit_restaurant_url(@restaurant)
    assert_response :success
  end

  test "should redirect on get edit" do
    get edit_restaurant_url(@restaurant)
    assert_response 302
  end

  test "should update restaurant" do
    login(users(:me))
    patch restaurant_url(@restaurant), params: { restaurant: { address: @restaurant.address, city: @restaurant.city, name: @restaurant.name, user_id: @restaurant.user_id, zip_code: @restaurant.zip_code } }
    assert_redirected_to restaurant_url(@restaurant)
  end

  test "should not update restaurant" do
    patch restaurant_url(@restaurant), params: { restaurant: { address: @restaurant.address, city: @restaurant.city, name: @restaurant.name, user_id: @restaurant.user_id, zip_code: @restaurant.zip_code } }
    assert_redirected_to root_path
  end

  test "should not destroy restaurant" do
    assert_no_difference('Restaurant.count') do
      delete restaurant_url(@restaurant)
    end

    assert_redirected_to root_path
  end

  test "should destroy restaurant" do
    login(users(:me))
    assert_difference('Restaurant.count', -1) do
      delete restaurant_url(@restaurant)
    end

    assert_redirected_to @restaurant.user
  end

  test "should get contact" do
    setup_restaurant_host
    get contact_url
    assert_response :success
  end

  test "should get contact redirect" do
    get contact_url
    assert_response 302
  end
end
