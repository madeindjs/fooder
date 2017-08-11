class Post < ApplicationRecord
  belongs_to :user

  validates_presence_of :user_id
  validates_presence_of :restaurant_id

  mount_uploader :picture, PictureUploader

  extend FriendlyId
  friendly_id :title, use: :slugged

  # Transform this object into an hash compatible to JSON-LD format
  #
  # @return [Hash]
  def to_jsonld
  end
end
