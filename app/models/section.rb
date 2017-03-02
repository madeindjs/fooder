class Section < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  mount_uploader :picture, PictureUploader
end
