require 'test_helper'

class MailingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mailing = mailings(:one)
  end

  test "should get index" do
    get mailings_url
    assert_response :success
  end

  test "should get new" do
    get new_mailing_url
    assert_response :success
  end

  test "should create mailing" do
    assert_difference('Mailing.count') do
      post mailings_url, params: { mailing: {  } }
    end

    assert_redirected_to mailing_url(Mailing.last)
  end

  test "should show mailing" do
    get mailing_url(@mailing)
    assert_response :success
  end

  test "should get edit" do
    get edit_mailing_url(@mailing)
    assert_response :success
  end

  test "should update mailing" do
    patch mailing_url(@mailing), params: { mailing: {  } }
    assert_redirected_to mailing_url(@mailing)
  end

  test "should destroy mailing" do
    assert_difference('Mailing.count', -1) do
      delete mailing_url(@mailing)
    end

    assert_redirected_to mailings_url
  end
end
