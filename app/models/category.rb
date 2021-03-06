class Category < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  validates_uniqueness_of :name, scope: :restaurant_id
  validates_presence_of :restaurant_id


  def self.find_or_create name, restaurant_id
    categories_founded = Category.where name: name, restaurant_id: restaurant_id
    if category = categories_founded.first
      return category
    else
      return Category.create name: name, restaurant_id: restaurant_id
    end
  end

end
