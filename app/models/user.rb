class User < ApplicationRecord
  validates :username, presence: true
  validates :email, presence: true
  validates :password, confirmation: true

  attr_accessor :password

  #
  acts_as_authentic
end
