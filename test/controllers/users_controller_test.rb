require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:me)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { email: 'test@test.fr', firstname: @user.firstname, lastname: @user.lastname, password: 20462046, password_confirmation: 20462046 } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should not create user because password don't match" do
    assert_no_difference('User.count') do
      post users_url, params: { user: { email: 'test@test.fr', firstname: @user.firstname, lastname: @user.lastname } }
    end
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should redirect on get edit" do
    get edit_user_url(@user)
    assert_response 302
  end

  test "should get edit" do
    login(users(:me))
    get edit_user_url(@user)
    assert_response :success
  end
  

  test "should redirect update user" do
    patch user_url(@user), params: { user: { email: @user.email, firstname: @user.firstname, lastname: @user.lastname } }
    assert_redirected_to root_url
  end

  test "should update user" do
    login(users(:me))
    patch user_url(@user), params: { user: { email: @user.email, firstname: @user.firstname, lastname: @user.lastname } }
    assert_redirected_to user_url(@user)
  end

  test "should not destroy user" do
    assert_no_difference('User.count') do
      delete user_url(@user)
    end

    assert_redirected_to root_url
  end

  test "should destroy user" do
    login(users(:me))
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end

  test "should not confirm email" do
    # get email & reset password
    my_girlfriend = users(:my_girlfriend)
    my_girlfriend.reset_email_token!
    assert_not my_girlfriend.activated
    my_girlfriend.reset_email_token!
    # send GET request to confirm email
    get confirm_email_url(token: 'bad_token')
    my_girlfriend.reload
    # check if user is confirmed
    assert_not my_girlfriend.activated
  end 

  test "should confirm email" do
    # get email & reset password
    my_girlfriend = users(:my_girlfriend)
    my_girlfriend.reset_email_token!
    assert_not my_girlfriend.activated
    # send GET request to confirm email
    get confirm_email_url(token: my_girlfriend.email_token)
    my_girlfriend.reload
    # check if user is confirmed
    assert my_girlfriend.activated
  end 
end
