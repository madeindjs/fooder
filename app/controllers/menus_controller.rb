class MenusController < ApplicationController
  before_action :set_menu, only: [:show, :edit, :update, :destroy]
  before_action :check_login, only: [:new, :create, :edits, :edit, :update, :destroy]
  before_action :check_owner, only: [:edit, :update, :destroy]
  before_action :check_admin, only: [:edits]

  layout 'admin', only: [:edit]

  # GET /menus
  # GET /menus.json
  def index
    @title = "Menus"
    @description = "Liste des menus proposés par #{@restaurant.name}."

    @menus = @restaurant.menus.where(activate: true).order :order
  end

  # GET /menus/1
  # GET /menus/1.json
  def show
    @title = @menu.name
    @description = "Un parmi les nombreux déliceux menus proposé par #{@restaurant.name}"
  end

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

    render  '_form', locals: {menu: @menu}, layout:  false if request.xhr?
  end



  # POST /menus
  # POST /menus.json
  def create
    @menu = Menu.new(menu_params)
    @menu.user_id = current_user.id
    @menu.restaurant_id = @restaurant.id

    if @menu.save
      flash[:success] = "Votre menu a été supprimé."
      redirect_to @menu
    else
      flash[:danger] = "Une erreur est survenue."
      render :new
    end
  end

  # PATCH/PUT /menus/1
  def update
    if @menu.update(menu_params)


      params['dishes'].each_pair do |dish_id, boolean|
        @menu.dishes << Dish.find(dish_id)
      end if params['dishes']

      flash[:success] = "Votre menu a été mise à jour."
      redirect_to @menu
    else
      flash[:danger] = "Une erreur est survenue."
      render :edit
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.json
  def destroy
    @menu.destroy
    flash[:success] = "Votre categorie a été mise à jour."
    redirect_to menus_path
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
end
