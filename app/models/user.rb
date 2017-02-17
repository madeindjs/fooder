class User < ApplicationRecord
  acts_as_authentic
  has_many :restaurants
  has_many :dishes
  has_many :categories

  def complete_name
    "#{self.lastname} #{self.firstname}"
  end

end
