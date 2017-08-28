class Mailing < ApplicationRecord

  belongs_to :restaurant

  def self.mails
    return RestaurantMailer.instance_methods(false).map {|m| m}
  end
end
