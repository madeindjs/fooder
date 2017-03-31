class Post < ApplicationRecord
  belongs_to :user

  validates_presence_of :user_id
  validates_presence_of :restaurant_id

  mount_uploader :picture, PictureUploader

  extend FriendlyId
  friendly_id :title, use: :slugged
end
