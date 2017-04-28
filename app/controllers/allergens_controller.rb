class AllergensController < ApplicationController
  before_action :check_restaurant
  before_action :check_admin, only: [:edits]

  # GET /allergens
  def index
    @title = "Carte des allergènes"
    @description = "Liste des allergènes présents dans nos plats."
  end


  def edits
    @title = "Gestion des allrgènes"
    @description = "Ajoutez rapidement les allrgènes de vos plat."

    @dishes = @restaurant.dishes.order :order
    @categories = @restaurant.categories
  end

end
