class Payement < ApplicationRecord

  def paypal_url
    values = {
      cmd: "_s-xclick",
      hosted_button_id: "2PQCPQ32JNP6A",
      amount: 20,
    }
  end
end
