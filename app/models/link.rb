class Link < ApplicationRecord
  belongs_to :restaurant

  validates_presence_of :name
  validates_presence_of :url
  validates_presence_of :restaurant_id
end
