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
      UserMailer.contact(contact_params.to_h).deliver_now
      flash[:success] = 'Votre demande à été transmise au support'
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def contact_params
    params.require('/contact').permit(:object, :email, :content)
  end

end
