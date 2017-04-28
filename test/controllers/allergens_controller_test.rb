require 'test_helper'

class AllergensControllerTest < ActionDispatch::IntegrationTest

  test "should get new" do
    login(users(:me))
    get allergens_url
    assert_response :success
  end


  test "should get edits" do
    login(users(:me))
    get allergens_edit_url
    assert_response :success
  end

  test "should redirect on get edits" do
    get allergens_edit_url
    assert_response :redirect
  end

end
