require 'test_helper'

class RestaurantTest < ActiveSupport::TestCase

  setup do
    @restaurant = restaurants(:one)
  end

  test "should create opening_hours" do
    restaurant = Restaurant.create name: "Good Pizza", user_id: 1
    assert_not_empty restaurant.opening_hours
  end

  test "should have default adress" do
    restaurant = Restaurant.create name: "Good Pizza", user_id: 1
    assert restaurant.address
    assert restaurant.zip_code
    assert restaurant.city
  end

  test "should create dishes" do
    restaurant = Restaurant.create name: "Good Pizza", user_id: 1
    assert_not_empty restaurant.dishes
  end

  test "should create menus" do
    restaurant = Restaurant.create name: "Good Pizza", user_id: 1
    assert_not_empty restaurant.menus
  end

  test "should create sections" do
    restaurant = Restaurant.create name: "Good Pizza", user_id: 1
    assert_not_empty restaurant.menus
  end

  test "should create categories" do
    restaurant = Restaurant.create name: "Good Pizza", user_id: 1
    assert_not_empty restaurant.categories
  end

end
