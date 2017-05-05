class Menu < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  has_and_belongs_to_many :dishes

  validates_presence_of :user_id
  validates_presence_of :restaurant_id

  mount_uploader :picture, PictureUploader

  include ImageFormat

  extend FriendlyId
  friendly_id :name, use: :slugged
end
