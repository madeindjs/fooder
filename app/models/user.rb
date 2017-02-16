class User < ApplicationRecord
  acts_as_authentic
  has_many :restaurants

  def complete_name
    "#{self.lastname} #{self.firstname}"
  end

end
