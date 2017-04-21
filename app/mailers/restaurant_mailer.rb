class RestaurantMailer < ApplicationMailer

  def contact data, restaurant_mail
    @content = data['content']
    @email   = data['email']
    @object  = data['object']
    mail(to: restaurant_mail, subject: @object)
  end

end
