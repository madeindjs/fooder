class Payement < ApplicationRecord
  belongs_to :product

  validates_presence_of :product_id
  validates_presence_of :user_id


  def paypal_url return_path

    values = {
        business: Rails.application.secrets.paypal_business_mail,
        cmd: "_xclick",
        upload: 1,
        return: return_path,# TODO: add a scren return to confirm payement
        invoice: id,
        amount: product.price,
        item_name: product.name,
        item_number: product.id,
        quantity: 1
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end

end
