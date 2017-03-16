class Category < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  validates_uniqueness_of :name


  def self.find_or_create name, restaurant_id
    categories_founded = Category.where name: name, restaurant_id: restaurant_id
    if category = categories_founded.first
      return category
    else
      return Category.create name: name, restaurant_id: restaurant_id
    end
  end

end
