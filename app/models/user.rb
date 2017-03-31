class User < ApplicationRecord
  acts_as_authentic
  has_many :opening_hours
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

end
