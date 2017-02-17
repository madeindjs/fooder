class Dish < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :restaurant
end
