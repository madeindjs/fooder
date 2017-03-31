class Menu < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  validates_presence_of :user_id
  validates_presence_of :restaurant_id

  mount_uploader :picture, PictureUploader

  include ImageFormat

  extend FriendlyId
  friendly_id :name, use: :slugged
end
