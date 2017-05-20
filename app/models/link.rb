class Link < ApplicationRecord
  belongs_to :restaurant
  belongs_to :link_type
  mount_uploader :logo, PictureUploader

  validates_presence_of :restaurant_id
end
