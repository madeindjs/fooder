require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get homs" do
    get home_url
    assert_response :success
  end

  test "should get cost" do
    get cost_url
    assert_response :success
  end
end
