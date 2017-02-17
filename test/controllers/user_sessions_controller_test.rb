require 'test_helper'
require "authlogic/test_case"

class UserSessionsControllerTest < ActionDispatch::IntegrationTest
  setup :activate_authlogic

  test "should get signin" do
    get signin_url
    assert_response :success
  end


  test "should signup and redirect to user" do
    ben = users(:ben)
    post user_sessions_url, params: {user_session: {:email => ben.email, :password => 'invalid'}}
    assert_redirected_to ben 
  end


  test "should not signup" do
    ben = users(:ben)
    post user_sessions_url, params: {user_session: {:email => ben.email, :password => 'invalid'}}
    assert_response :success
  end
end
