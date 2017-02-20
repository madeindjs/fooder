class User < ApplicationRecord
  acts_as_authentic
  has_many :restaurants
  has_many :dishes
  has_many :categories
  has_many :sections
  has_many :posts

  after_create :generate_categories

  acts_as_authentic do |c|
    c.crypto_provider = Authlogic::CryptoProviders::Sha512
  end

  def complete_name
    "#{self.lastname} #{self.firstname}"
  end

  private 

  def generate_categories
  	['Entrée', 'Plat', 'Dessert', 'Boisson', 'Sauce'].each do |category_name|
  		Category.create name: category_name, user_id: self.id
  	end
  end

end
