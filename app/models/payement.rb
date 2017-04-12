class Payement < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates_presence_of :product_id
  validates_presence_of :user_id

  after_save :update_user_premium


  def paypal_url return_path

    values = {
        business: Rails.application.secrets.paypal_business_mail,
        cmd: "_xclick",
        upload: 1,
        return: return_path,
        invoice: id,
        amount: product.price,
        currency_code: 'EUR',
        item_name: product.name,
        item_number: product.id,
        quantity: 1,
        notify_url: Rails.application.routes.url_helpers.payement_hook_url(host: Rails.application.secrets.app_host)

    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end


  def complete_address
    "#{address_street}, #{address_zip}, #{address_city}, #{address_country}"
  end

  # Get end date of validity
  def actual_until
    return Time.now unless self.payment_status == "Completed"
    return self.purchased_at + self.product.months.month rescue NoMethodError
  end

  # check if the payement make user premium
  def actual?
    return false unless self.payment_status == "Completed"
    self.product.unlimited? ? true : Time.now < self.actual_until
  end

  private

  def update_user_premium
    now = Time.now
    u   = self.user
    # if product is unlimited, we add 200 years to premium_until properties (it should be ok)
    if self.product.unlimited?
      u.premium_until = now + 200.years
    # else we add 
    else
      base_time = (u.premium_until and now < u.premium_until) ? u.premium_until : now
      u.premium_until = base_time + self.product.months.month
    end
    u.save
  end

end
