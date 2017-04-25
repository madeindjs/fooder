require 'test_helper'

class UserTest < ActiveSupport::TestCase

  setup do
    @user = users(:ben)
  end

  test "should be premium with one month product" do
    p = Payement.create product_id: 1, user_id: @user.id, txn_id: '7EY63019RG364010H', mc_gross: 99.99, 
      payment_status: 'Completed', payer_email: 'rousseaualexandre.lyon-buyer@gmail.com', purchased_at: Time.now

    assert p.user.payements
    assert p.user.premium?
  end


  test "should be premium with unlimited product" do
    p = Payement.create product_id: 2, user_id: @user.id, txn_id: '7EY63019RG364010H', mc_gross: 99.99, 
      payment_status: 'Completed', payer_email: 'rousseaualexandre.lyon-buyer@gmail.com', purchased_at: Time.now

    assert p.user.payements
    assert p.user.premium?
  end

  # Create two payement at the same time, the premium time should be additionned to the first
  test "should be increment premium time" do
    purchased_time = Time.now
    data = {
      product_id: 2, user_id: @user.id, txn_id: '7EY63019RG364010H', mc_gross: 99.99, 
      payment_status: 'Completed', payer_email: 'rousseaualexandre.lyon-buyer@gmail.com', purchased_at: purchased_time
    }
    # create two differents payements with the same data
    first_payment  = Payement.create(data)
    second_payment = Payement.create(data)
    
    assert_not_same second_payment.user.premium_until.to_i,  second_payment.actual_until.to_i
  end
  
  
  test "should not be premium" do
    assert @user.payements.empty?
    assert_not @user.premium?
  end


  test "should delivering password instructions" do
    assert_empty @user.perishable_token
    @user.deliver_password_reset_instructions!
    assert_not_empty @user.perishable_token
  end

end
