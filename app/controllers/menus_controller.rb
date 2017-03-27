class MenusController < ApplicationController
  before_action :set_menu, only: [:show, :edit, :update, :destroy]
  before_action :check_login, only: [:new, :create, :edits, :edit, :update, :destroy]
  before_action :check_owner, only: [:edit, :update, :destroy]
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

  # GET /menus/edit
  # POST /menus/edit
  def edits
    @title = "Gérer les menus"
    @description = "Renommer et réorganisez les menu proposés par ce restaurant."

    redirect_to root_path unless current_user.restaurants.include? @restaurant
    @menus = @restaurant.menus.order :order
    if request.post?
      # to array to save changes to display it to user
      updated_menus = []
      fail_updated_menus = []
      # loop on all parameters
      params.require(:menu).each do |id, data|
        # we get menu and verify author is the user
        if menu = Menu.find(id) and menu.user_id == current_user.id
          # update attributes
          menu.name  = data['name']
          menu.price = data['price']
          menu.order = data['order']
          menu.activate = data['activate']
          # save only if menu changed
          if menu.changed?
            # save menu and stor in array to display in flash message
            if menu.save
              updated_menus << menu.name
            else
              fail_updated_menus << menu.name
            end
          end
        end
      end
      # display changes
      flash[:success] = "La mise à jour de #{updated_menus} a été effectuée." unless updated_menus.empty?
      flash[:danger] = "La mise à jour de #{fail_updated_menus} n'a été effectuée."  unless fail_updated_menus.empty?
    end
  end

  # POST /menus
  # POST /menus.json
  def create
    @menu = Menu.new(menu_params)
    @menu.user_id = current_user.id
    @menu.restaurant_id = @restaurant.id

    respond_to do |format|
      if @menu.save
        flash[:success] = "Votre menu a été supprimé."
        format.html { redirect_to @menu }
        format.json { render :show, status: :created, location: @menu }
      else
        flash[:danger] = "Une erreur est survenue."
        format.html { render :new }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /menus/1
  # PATCH/PUT /menus/1.json
  def update
    respond_to do |format|
      if @menu.update(menu_params)
        flash[:success] = "Votre menu a été mise à jour."
        format.html { redirect_to @menu }
        format.json { render :show, status: :ok, location: @menu }
      else
        flash[:danger] = "Une erreur est survenue."
        format.html { render :edit }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.json
  def destroy
    @menu.destroy
    flash[:success] = "Votre categorie a été mise à jour."
    respond_to do |format|
      format.html { redirect_to menus_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu
      @menu = Menu.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_params
      params.require(:menu).permit(:name, :description, :content, :tags, :price, :picture, :activate)
    end

    def check_owner
      redirect_to root_path unless current_user.menus.include? @menu
    end
end
