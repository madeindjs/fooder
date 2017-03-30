require 'test_helper'

class PayementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payement = payements(:one)
  end

  test "should get index" do
    get payements_url
    assert_response :success
  end

  test "should get new" do
    get new_payement_url
    assert_response :success
  end

  test "should create payement" do
    assert_difference('Payement.count') do
      post payements_url, params: { payement: { status: @payement.status, transaction_id: @payement.transaction_id, user_id: @payement.user_id } }
    end

    assert_redirected_to payement_url(Payement.last)
  end

  test "should show payement" do
    get payement_url(@payement)
    assert_response :success
  end

  test "should get edit" do
    get edit_payement_url(@payement)
    assert_response :success
  end

  test "should update payement" do
    patch payement_url(@payement), params: { payement: { status: @payement.status, transaction_id: @payement.transaction_id, user_id: @payement.user_id } }
    assert_redirected_to payement_url(@payement)
  end

  test "should destroy payement" do
    assert_difference('Payement.count', -1) do
      delete payement_url(@payement)
    end

    assert_redirected_to payements_url
  end
end
