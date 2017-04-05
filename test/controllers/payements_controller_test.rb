require 'test_helper'

class PayementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:me)
    @payement = payements(:one)
  end

  test "should redirect on get index" do
    get payements_url
    assert_response 302
  end

  test "should get index" do
    login(@user)
    get payements_url
    assert_response :success
  end

  test "should redirect on get new" do
    get new_payement_url
    assert_response 302
  end

  test "should get new" do
    login(@user)
    get new_payement_url
    assert_response :success
  end

  test "should redirect on create payement" do
    assert_no_difference('Payement.count') do
      post payements_url, params: { payement: { status: @payement.status, product_id: @payement.product_id } }
    end
  end

  test "should create payement" do
    login(@user)
    assert_difference('Payement.count') do
      post payements_url, params: { payement: { status: @payement.status, product_id: @payement.product_id } }
    end

    payement = Payement.last

    assert_redirected_to payement.paypal_url(payement_url(payement))
  end

  test "should redirect show payement" do
    get payement_url(@payement)
    assert_response 302
  end

  test "should show payement" do
    login(@user)
    get payement_url(@payement)
    assert_response :success
  end

end
