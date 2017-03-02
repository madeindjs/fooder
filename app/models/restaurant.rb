require 'yaml'

class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :dishes
  has_many :menus
  has_many :sections
  has_many :posts
  has_many :opening_hours

  after_create :generate_dishes
  after_create :generate_menus
  after_create :generate_sections

  mount_uploader :logo, PictureUploader
  mount_uploader :picture, PictureUploader

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
    yaml_file = Rails.root.join 'app', 'assets', 'models', 'menus.yml'
    YAML.load_file( yaml_file ).each do |menu_data|
      menu = Menu.new menu_data
      menu.user_id = self.user_id
      menu.restaurant_id = self.id
      menu.save
    end
  end

  def generate_sections
    yaml_file = Rails.root.join 'app', 'assets', 'models', 'sections.yml'
    YAML.load_file( yaml_file ).each do |section_data|
      section = Section.new section_data
      section.user_id = self.user_id
      section.restaurant_id = self.id
      section.save
    end
  end

end
