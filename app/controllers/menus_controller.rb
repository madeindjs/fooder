class MenusController < ApplicationController
  before_action :set_menu, only: [:show, :edit, :update, :destroy]
  before_action :check_login, only: [:new, :create, :edit, :update, :destroy]
  before_action :check_owner, only: [:edit, :update, :destroy]
  # GET /menus
  # GET /menus.json
  def index
    @title = "Menus"
    @menus = Menu.all
  end

  # GET /menus/1
  # GET /menus/1.json
  def show
    @title = @menu.name
  end

  # GET /menus/new
  def new
    @menu = Menu.new
  end

  # GET /menus/1/edit
  def edit
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
      params.require(:menu).permit(:name, :description, :content, :tags, :price, :picture)
    end

    def check_owner
      redirect_to root_path unless current_user.menus.include? @menu
    end
end
