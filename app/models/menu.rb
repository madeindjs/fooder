class Menu < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  has_and_belongs_to_many :dishes

  validates_presence_of :user_id
  validates_presence_of :restaurant_id

  mount_uploader :picture, PictureUploader

  include ImageFormat

  extend FriendlyId
  friendly_id :name, use: :slugged

  # Transform this object into an hash compatible to JSON-LD format
  #
  # @return [Hash]
  def to_jsonld
  end
end
