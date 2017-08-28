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
      post mailings_url, params: { mailing: { restaurant_id: 1, mail: 'Test' } }
    end

    assert_redirected_to mailings_url
  end

  test "should redirect on create mailing" do
    assert_no_difference('Mailing.count') do
      post mailings_url, params: { mailing: {  } }
    end

    assert_response 302
  end

end
