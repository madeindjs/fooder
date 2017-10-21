class RestaurantMailer < ApplicationMailer

  def contact data, restaurant_mail
    @content = data['content']
    @email   = data['email']
    @object  = data['object']
    mail(to: restaurant_mail, subject: @object)
  end

  def commercial restaurant
    @email   = 'a.rousseau@votre.restaurant'
    @object  = 'Bienvenue sur Fooder'
    @restaurant  = restaurant
    mail(to: restaurant.email, subject: @object)
  end

end
