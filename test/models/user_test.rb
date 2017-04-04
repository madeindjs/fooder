require 'test_helper'

class UserTest < ActiveSupport::TestCase

  setup do
    @user = users(:ben)
  end

  test "should be premium with one month product" do
    payements = Payement.create product_id: 1, user_id: @user.id, txn_id: '7EY63019RG364010H', mc_gross: 99.99, 
      payment_status: 'Completed', payer_email: 'rousseaualexandre.lyon-buyer@gmail.com', purchased_at: Time.now

    assert @user.payements
    assert @user.premium?
  end


  test "should be premium with unlimited product" do
    payements = Payement.create product_id: 2, user_id: @user.id, txn_id: '7EY63019RG364010H', mc_gross: 99.99, 
      payment_status: 'Completed', payer_email: 'rousseaualexandre.lyon-buyer@gmail.com', purchased_at: Time.now

    assert @user.payements
    assert @user.premium?
  end
  
  
  test "should not be premium" do
    assert @user.payements.empty?
    assert_not @user.premium?
  end

end
