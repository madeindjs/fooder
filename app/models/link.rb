class Link < ApplicationRecord
  belongs_to :restaurant
  mount_uploader :logo, PictureUploader

  validates_presence_of :restaurant_id
end
