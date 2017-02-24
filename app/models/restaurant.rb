require 'yaml'

class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :dishes
  has_many :menus
  has_many :sections
  has_many :posts

  after_create :generate_dishes
  after_create :generate_menus

  def complete_address
    "#{self.address}, #{self.zip_code}, #{self.city}"
  end

  private

  def generate_dishes
    yaml_file = Rails.root.join 'app', 'assets', 'models', 'dishes.yml'
    YAML.load_file( yaml_file ).each do |dish_data|
      # create category
      category = Category.find_or_create dish_data['category_name'], @user_id
      dish_data.delete 'category_name'

      # create dish
      dish = Dish.new dish_data
      dish.user_id = self.user_id
      dish.restaurant_id = self.id
      dish.category_id = category.id
      dish.save
    end
  end

  def generate_menus
  end

end
