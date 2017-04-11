require 'test_helper'

class OpeningHoursControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:me)
    @opening_hour = opening_hours(:one)
    @restaurant = restaurants(:one)
    setup_restaurant_host
  end


  test "should redirect on get edits" do
    get opening_hours_edit_url
    assert_response 302
  end


  test "should get edits" do
    login(@user)
    get opening_hours_edit_url
    assert_response :success
  end


  test "should not create opening hours" do
    assert_no_difference('OpeningHour.count') do
      post opening_hours_edit_url, params: { opening_hour: { 
        "1"    => { day: @opening_hour.day, closes: @opening_hour.closes, opens: @opening_hour.opens, valid_from: @opening_hour.valid_from, valid_through: @opening_hour.valid_through},
        "1000" => { day: 7, closes: @opening_hour.closes, opens: @opening_hour.opens, valid_from: @opening_hour.valid_from, valid_through: @opening_hour.valid_through},
      } }
    end
  end


  test "should create opening hours" do
    login(@user)

    assert_difference('OpeningHour.count', 1) do
      post opening_hours_edit_url, params: { opening_hour: { 
        "1"    => { day: @opening_hour.day, closes: @opening_hour.closes, opens: @opening_hour.opens, valid_from: @opening_hour.valid_from, valid_through: @opening_hour.valid_through},
        "1000" => { day: 7, closes: @opening_hour.closes, opens: @opening_hour.opens, valid_from: @opening_hour.valid_from, valid_through: @opening_hour.valid_through},
      } }
    end
  end

  test "should not update opening hours" do
    old_day = @opening_hour.day

    post opening_hours_edit_url, params: { opening_hour: { 
      @opening_hour.id    => { day: 6, closes: @opening_hour.closes, opens: @opening_hour.opens, valid_from: @opening_hour.valid_from, valid_through: @opening_hour.valid_through},
    } }

    assert_equal old_day, OpeningHour.find(@opening_hour.id).day
  end


  test "should update opening hours" do
    login(@user)

    old_day = @opening_hour.day

    post opening_hours_edit_url, params: { opening_hour: { 
      @opening_hour.id    => { day: 6, closes: @opening_hour.closes, opens: @opening_hour.opens, valid_from: @opening_hour.valid_from, valid_through: @opening_hour.valid_through},
    } }

    assert_not_equal old_day, OpeningHour.find(@opening_hour.id).day

  end


  test "should not create opening_hour" do
    assert_no_difference('OpeningHour.count') do
      post opening_hours_url, params: { opening_hour: { day: @opening_hour.day, closes: @opening_hour.closes, opens: @opening_hour.opens, valid_from: @opening_hour.valid_from, valid_through: @opening_hour.valid_through} }
    end
  end


  test "should create opening_hour" do
    login(@user)
    assert_difference('OpeningHour.count') do
      post opening_hours_url, params: { opening_hour: { day: @opening_hour.day, closes: @opening_hour.closes, opens: @opening_hour.opens, valid_from: @opening_hour.valid_from, valid_through: @opening_hour.valid_through } }
    end

    assert_redirected_to opening_hours_url
  end


  test "should redirect on destroy opening_hour" do
    assert_no_difference('OpeningHour.count') do
      delete opening_hour_url(@opening_hour)
    end

    assert_redirected_to root_url
  end


  test "should destroy opening_hour" do
    login(@user)
    assert_difference('OpeningHour.count', -1) do
      delete opening_hour_url(@opening_hour)
    end

    assert_redirected_to opening_hours_url
  end
end
