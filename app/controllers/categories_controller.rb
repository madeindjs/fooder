class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]
  before_action :check_login
  before_action :check_owner, only: [:edit, :update, :destroy]

  def index
    @categories = @restaurant.categories
  end


  # GET /categories/new
  def new
    @title = "Nouvelle catégorie"
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)
    @category.user_id = current_user.id

    if @category.save
      flash[:success] = "Votre categorie a été crée avec succès."
      redirect_to current_user
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
        redirect_to current_user
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
    redirect_to current_user
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
      redirect_to root_path unless current_user.categories.include? @category
    end
end
