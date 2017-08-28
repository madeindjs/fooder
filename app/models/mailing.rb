class Mailing < ApplicationRecord

  def self.mails
    return RestaurantMailer.instance_methods(false).map {|m| "RestaurantMailer.#{m}"}
  end
end
