class PagesController < ApplicationController

  def home
    @title = "Accueil"
    @description = "Génerez votre site pour votre restaurant."

    render layout: 'application_landing'
  end

  def cost
    @title = "Prix"
    @description = "Descriptif de la grille tarifaire."
  end

end
