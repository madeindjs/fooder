class Product < ApplicationRecord
  has_many :payements

  def self.options_for_select
    ActionController::Base.helpers.options_for_select Product.all.map{ |p| [ "#{p.name} ( #{p.price} €)" , p.id] }
  end

  def unlimited?
    return months == 0
  end

end
