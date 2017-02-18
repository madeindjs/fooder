class User < ApplicationRecord
  acts_as_authentic
  has_many :restaurants
  has_many :dishes
  has_many :categories

  after_create :generate_categories

  def complete_name
    "#{self.lastname} #{self.firstname}"
  end

  private 

  def generate_categories
  	['Entrée', 'Plat', 'Dessrt', 'Boisson', 'Sauce'].each do |category_name|
  		Category.create name: category_name, user_id: self.id
  	end
  end

end
