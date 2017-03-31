class Payement < ApplicationRecord
  PRICES = [
    ['1 mois (9,99€)', 9.99],
    ['3 mois (26,99€)', 26.99],
    ['6 mois (55,99€)', 55.99],
    ['1 an (99,99€)', 99.99],
    ['2 ans (199,99€)', 199.99],
    ['A vie (259.99€)', 259.99],
  ]


  def paypal_url
    values = {
      cmd: "_s-xclick",
      hosted_button_id: "2PQCPQ32JNP6A",
      amount: 20,
    }
  end
end
