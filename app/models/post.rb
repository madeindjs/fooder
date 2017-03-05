class Post < ApplicationRecord
  belongs_to :user

  mount_uploader :picture, PictureUploader

  extend FriendlyId
  friendly_id :title, use: :slugged
end
