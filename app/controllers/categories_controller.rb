class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]
  before_action :check_login
  before_action :check_owner, only: [:edit, :update, :destroy]

  # GET /categories/new
  def new
    @title = "Nouvelle catégorie"
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # GET  /categories/edit
  # POST /categories/edit
  def edits
    redirect_to root_path unless current_user.restaurants.include? @restaurant
    @categories = @restaurant.categories.order :order
    if request.post?
      # to array to save changes to display it to user
      updated_categories = []
      fail_updated_categories = []
      # loop on all parameters
      params.require(:categories).each do |id, data|
        # we get category and verify author is the user
        if category = Category.find(id) and category.restaurant_id == @restaurant.id
          # update attributes
          category.name = data['name']
          category.order = data['order']
          # save only if category changed
          if category.changed?
            # save category and stor in array to display in flash message
            if category.save
              updated_categories << category.name
            else
              fail_updated_categories << category.name
            end
          end
        end
      end
      # display changes
      flash[:success] = "La mise à jour de #{updated_categories} a été effectuée." unless updated_categories.empty?
      flash[:danger] = "La mise à jour de #{fail_updated_categories} n'a été effectuée."  unless fail_updated_categories.empty?
    end
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)
    @category.restaurant_id = @restaurant.id

    if @category.save
      flash[:success] = "Votre categorie a été créé avec succès."
      redirect_to categories_path
    else
      flash[:danger] = "Une erreur est survenue."
      render :new
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
      if @category.update(category_params)
        flash[:success] = "Votre categorie a été mise à jour."
        redirect_to categories_path
      else
        flash[:danger] = "Une erreur est survenue."
        render :edit
      end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    flash[:success] = "Votre categorie a été supprimée."
    redirect_to categories_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :user_id)
    end

    def check_owner
      redirect_to root_path unless current_user.restaurants.include? @category.restaurant
    end
end
