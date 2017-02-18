require 'test_helper'

class UserSessionsControllerTest < ActionDispatch::IntegrationTest

  test "should get signin" do
    get signin_url
    assert_response :success
  end


  test "should signup and redirect to user" do
    me = users(:me)
    post user_sessions_url, params: {user_session: {email: me.email, password: '20462046'}}
    assert_logged_in
    assert_redirected_to me 
  end


  test "should not signup" do
    ben = users(:ben)
    post user_sessions_url, params: {user_session: {email: ben.email, password: 'invalid'}}
    assert_response :success
  end
end
