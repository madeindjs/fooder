class Dish < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :restaurant

  mount_uploader :avatar, PictureUploader
end
