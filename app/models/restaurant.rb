class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :dishes

  def complete_address
    "#{self.address}, #{self.zip_code}, #{self.city}"
  end

end
