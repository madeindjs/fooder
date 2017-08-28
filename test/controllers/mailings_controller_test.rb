require 'test_helper'

class MailingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mailing = mailings(:one)
  end

  test "should get index" do
    login(users(:super_user))
    get mailings_url
    assert_response :success
  end

  test "should redirect on get index" do
    get mailings_url
    assert_response 302
  end

  test "should get new" do
    login(users(:super_user))
    get new_mailing_url
    assert_response :success
  end

  test "should redirect on get new" do
    get new_mailing_url
    assert_response 302
  end

  test "should create mailing" do
    login(users(:super_user))
    assert_difference('Mailing.count') do
      post mailings_url, params: { mailing: {  } }
    end

    assert_redirected_to mailing_url(Mailing.last)
  end

  test "should redirect on create mailing" do
    assert_no_difference('Mailing.count') do
      post mailings_url, params: { mailing: {  } }
    end

    assert_response 302
  end

  test "should show mailing" do
    login(users(:super_user))
    get mailing_url(@mailing)
    assert_response :success
  end

  test "should redirect on show mailing" do
    get mailing_url(@mailing)
    assert_response 302
  end

  test "should get edit" do
    login(users(:super_user))
    get edit_mailing_url(@mailing)
    assert_response :success
  end

  test "should redirect on get edit" do
    get edit_mailing_url(@mailing)
    assert_response 302
  end

  test "should update mailing" do
    login(users(:super_user))
    patch mailing_url(@mailing), params: { mailing: {  } }
    assert_redirected_to mailing_url(@mailing)
  end

  test "should redirect on update mailing" do
    patch mailing_url(@mailing), params: { mailing: {  } }
    assert_response 302
  end

  test "should destroy mailing" do
    login(users(:super_user))
    assert_no_difference('Mailing.count') do
      delete mailing_url(@mailing)
    end

    assert_response 302
  end

  test "should redirect on destroy mailing" do
    assert_no_difference('Mailing.count') do
      delete mailing_url(@mailing)
    end

    assert_response 302
  end
end
