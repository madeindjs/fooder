class MenusController < ApplicationController
  before_action :set_menu, only: [:show, :edit, :update, :destroy, :copy]
  before_action :check_login, only: [:new, :create, :edit, :edits, :update, :destroy]
  before_action :check_owner, only: [:edit, :update, :destroy]
  before_action :check_admin, only: [:edits, :allergens, :import]
  before_action :check_restaurant

  # GET /menus
  # GET /menus.json
  # def index
  #   @title = "Menus"
  #   @description = "Liste des menus proposés par #{@restaurant.name}."

  #   @menus = @restaurant.menus.where(activate: true).order :order
  #   @jsonld = {
  #     "@context":"http://schema.org",
  #     "@type":"ItemList",
  #     "itemListElement": @menus.map{|menu| menu.to_jsonld}
  #   }
  # end

  # GET /menus/1
  # GET /menus/1.json
  # def show
  #   @title = @menu.name
  #   @description = "Un parmi les nombreux déliceux menus proposé par #{@restaurant.name}"
  #   @jsonld = @menu.to_jsonld
  # end

  # GET /menus/new
  def new
    @title = "Nouveau menu"
    @description = "Créez un nouveau menu que vos clients pourons déguster."

    @menu = Menu.new
  end

  # GET /menus/1/edit
  def edit
    @title = "Editer #{@menu.name}"
    @description = "Editer un menu déjà existant."

    render  '_form', locals: {menu: @menu}, layout: false
  end

  # GET /menus/1/copy
  def copy
    new_menu = @menu.dup
    new_menu.root_menu_id = @menu.id
    new_menu.name += " (copie)"
    new_menu.dishes = @menu.dishes
    if new_menu.save
      flash[:success] = "Votre menu a été copié."
      redirect_to new_menu
    else
      flash[:danger] = "Une erreur est survenue."
      redirect_back fallback_location: menu_path(@menu)
    end
  end

  # POST /menus
  # POST /menus.json
  def create
    @menu = Menu.new(menu_params)
    @menu.user_id = current_user.id
    @menu.restaurant_id = @restaurant.id

    add_dishes

    if @menu.save
      flash[:success] = "Votre menu a été crée."
      redirect_to @menu
    else
      flash[:danger] = "Une erreur est survenue."
      render :new
    end
  end

  # PATCH/PUT /menus/1
  def update
    if @menu.update(menu_params)
      # add_dishes
      render  'menus/_list', locals: {menus: @restaurant.menus_ordered}, layout: false
    else
      render plain: "Une erreur est survenue."
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.json
  def destroy
    @menu.destroy
    flash[:success] = "Votre categorie a été mise à jour."
    redirect_to admin_menus_path
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_menu
    @menu = Menu.includes(:dishes).friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def menu_params
    params.require(:menu).permit(:name, :description, :content, :tags, :price, :picture, :activate)
  end

  def check_owner
    redirect_to root_path unless current_user.menus.include? @menu
  end

  # Add selected dishes to @menu
  def add_dishes
    params['dishes'].each_pair do |dish_id, boolean|
      @menu.dishes << Dish.find(dish_id)
    end if params['dishes']
  end
end
