require 'test_helper'

class PasswordResetsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = users(:me)
  end

  test "should get new" do
    get new_password_reset_url
    assert_response :success
  end
 
  test "should create " do
    post password_resets_url, params: {email: @user.email}
    assert_redirected_to root_url
  end

  test "should get edit" do
    get edit_password_reset_url(@user.perishable_token)
    assert_response :success
  end

  test "should update" do 
    put password_reset_url(@user.perishable_token), params: {user: { password: "newpassword" } }
    assert_redirected_to user_url(@user)
  end

end
