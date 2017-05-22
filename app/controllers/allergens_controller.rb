class AllergensController < ApplicationController
  before_action :check_restaurant
  before_action :check_admin, only: [:edits]

  # GET /allergens
  def index
    @title = "Carte des allergènes"
    @description = "Liste des allergènes présents dans nos plats."
  end

end
