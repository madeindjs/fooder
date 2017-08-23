class PagesController < ApplicationController

  def home
    @title = "Accueil"
    @description = "Génerez votre site pour votre restaurant."

    render layout: 'application_landing'
  end

  def contact
    @title = "Contact"
    @description = "Une question? N'hésitez pas à nous contacter par mail."
    if request.post?
      if @restaurant
        RestaurantMailer.contact(contact_params.to_h, @restaurant.email).deliver_now
        flash[:success] = 'Votre demande à été transmise au support'
      else
        UserMailer.contact(contact_params.to_h).deliver_now
        flash[:success] = 'Votre demande à été transmise au support'
      end
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def contact_params
    params.require('/contact').permit(:object, :email, :content)
  end

end
