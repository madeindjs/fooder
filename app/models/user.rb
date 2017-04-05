class User < ApplicationRecord
  acts_as_authentic
  has_many :opening_hours
  has_many :payements
  has_many :restaurants
  has_many :menus
  has_many :dishes
  has_many :sections
  has_many :posts

  validates_uniqueness_of :email

  mount_uploader :picture, PictureUploader

  extend FriendlyId
  friendly_id :firstname, use: :slugged

  acts_as_authentic do |c|
    c.crypto_provider = Authlogic::CryptoProviders::Sha512
  end


  def complete_name
    "#{self.lastname} #{self.firstname}"
  end

  # Create a unique number to generate a key to accross session between domain
  def public_login_key
    Digest::SHA1.hexdigest "#{self.crypted_password}_#{self.last_request_at}"
  end

  # Check if the user is premium
  def premium?
    return @premium if @premium
    # check if user has payements
    if last_payement = payements.last
      # is unlimited product
      return @premium = last_payement.product.unlimited? ? true :Time.now < last_payement.valid_until
    end
    return @premium = false
  end

  def paypal_url(return_path)
    values = {
        business: "merchant@gotealeaf.com",
        cmd: "_xclick",
        upload: 1,
        return: "#{Rails.application.secrets.app_host}#{return_path}",
        invoice: id,
        amount: course.price,
        item_name: course.name,
        item_number: course.id,
        quantity: '1'
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end


end
