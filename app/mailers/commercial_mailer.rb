class CommercialMailer < ApplicationMailer
  default from: 'a.rousseau@votre.restaurant'

  helper RestaurantsHelper


  def self.all
    return CommercialMailer.instance_methods(false)
  end

  def presentation restaurant
    @object  = 'Bienvenue sur Votre.Restaurant'
    @restaurant  = restaurant
    mail(to: restaurant.email, subject: @object)
  end

end
