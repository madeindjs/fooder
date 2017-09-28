class DishesController < ApplicationController
  before_action :set_dish, only: [:show, :edit, :update, :destroy]
  before_action :check_login, only: [:new, :create, :edit, :edits, :update, :destroy]
  before_action :check_owner, only: [:edit, :update, :destroy]
  before_action :check_admin, only: [:edits, :allergens, :import]
  before_action :check_restaurant

  layout 'admin', only: [:edit, :new]

  # GET /dishes
  # GET /dishes.json
  def index
    @title = "Carte"
    @description = "Carte des produits proposés par ce restaurant."

    @dishes = @restaurant.dishes.where(activate: true).order :order
    @jsonld = {
      "@context":"http://schema.org",
      "@type":"ItemList",
      "itemListElement": @dishes.map{|dish| dish.to_jsonld}
    }
  end

  # GET /dishes/1
  # GET /dishes/1.json
  def show
    @title = @dish.name
    @description = "Un parmi les nombreux déliceux produits proposé par #{@restaurant.name}"

    @menus = @dish.menus.uniq
  end

  # GET /dishes/new
  def new
    @title = "Nouveau produit"
    @description = "Créer un nouveau plat que les clients pourons déguster."

    @dish = Dish.new
  end

  # GET /dishes/1/edit
  def edit
    @title = "Editer #{@restaurant.name}"
    @description = "Editer une catégorie existante."
    render layout: false
  end


  # POST /dishes
  # POST /dishes.json
  def create
    @dish = Dish.new(dish_params)
    @dish.user_id = current_user.id
    @dish.restaurant_id = @restaurant.id

    if @dish.save
      flash[:success] = "Votre plat a l'air délicieux!"
      redirect_to @dish
    else
      flash[:danger] = "Une erreur est survenue."
      render :new
    end
  end

  # PATCH/PUT /dishes/1
  def update
    if @dish.update(dish_params)
      flash[:success] = "Votre plat a été mis à jour avec succès."
      render  'dishes/_list', locals: {dishes: @restaurant.dishes_ordered}, layout:  false if request.xhr?
    else
      flash[:danger] = "Une erreur est survenue."
      render :edit
    end
  end

  # DELETE /dishes/1
  def destroy
    @dish.destroy
    redirect_back fallback_location: dishes_path
  end

  # PATCH /dishes/1/sort/1
  def sort
    @dishes = @restaurant.dishes
  end


  # GET  /admin/dishes/import
  # POST /admin/dishes/import
  def import
    if request.post?
      imported_dishes = []
      failed_dishes = []

      params['csv'].each_line do |line|
        data = line.split(';')
        begin
          category = Category.find_or_create data[3], @restaurant.id

          dish = Dish.create(
            user_id: current_user.id, category_id: category.id, restaurant_id: @restaurant.id,
            name: data[0], description: data[1], price: data[2]
          )
          if dish.id
            imported_dishes << dish.name
          else
            failed_dishes << dish.name
          end
        rescue Exception => e
        end
      end
      flash[:success] = "#{imported_dishes} ont été importé." unless imported_dishes.empty?
      flash[:danger] = "La mise à jour de #{failed_dishes} n'ont pas été importé."  unless failed_dishes.empty?
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_dish
    @dish = Dish.friendly.find(params[:id])
    redirect_to root_path unless @dish
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def dish_params
    params.require(:dish).permit :name, :description, :category_id, :price, :tags, :picture, :activate,
      :gluten_free, :crustacea_free, :egg_free, :fish_free, :peanut_free, :lactose_free, :nut_free, :sulphite_free
  end

  def check_owner
    redirect_to root_path unless current_user.dishes.include? @dish
  end
end
