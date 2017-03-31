class Section < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  validates_presence_of :user_id
  validates_presence_of :restaurant_id

  mount_uploader :picture, PictureUploader
end
