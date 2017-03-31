class Product < ApplicationRecord

  def self.options_for_select
    ActionController::Base.helpers.options_for_select Product.all.map{ |p| [ "#{p.name} ( #{p.price} €)" , p.price] }
  end

end
