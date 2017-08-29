class CommercialMailer < ApplicationMailer
  default from: 'a.rousseau@fooder.pro'


  def self.all
    return CommercialMailer.instance_methods(false)
  end

  def presentation restaurant
    @object  = 'Bienvenue sur Fooder'
    @restaurant  = restaurant
    mail(to: restaurant.email, subject: @object)
  end

end
