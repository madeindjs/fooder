class User < ApplicationRecord
  acts_as_authentic
  has_many :opening_hours
  has_many :restaurants
  has_many :menus
  has_many :dishes
  has_many :sections
  has_many :posts

  mount_uploader :picture, PictureUploader

  extend FriendlyId
  friendly_id :firstname, use: :slugged

  acts_as_authentic do |c|
    c.crypto_provider = Authlogic::CryptoProviders::Sha512
  end

  def complete_name
    "#{self.lastname} #{self.firstname}"
  end

end
