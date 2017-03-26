class Link < ApplicationRecord
  belongs_to :restaurant
  mount_uploader :logo, PictureUploader
end
