class PagesController < ApplicationController

  def home
    @title = "Accueil"
    @description = "Génerez votre site pour votre restaurant."

    render layout: 'application_landing'
  end

  def contact
    @title = "Contact"
    @description = "Formulaire de contact au support."
  end

end
