class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  before_action :check_owner, only: [:edit, :update, :destroy]
  before_action :check_admin, only: [:edits]

  layout 'admin', only: [:edit, :new]


  # GET /links/new
  def new
    @title = "Créer un Lien"
    @description = "Créer un nouveau lien vers votre restaurant."

    @link = Link.new
  end

  # GET /links/1/edit
  def edit
    @title = "Editer un lien"
    @description = "Editer le lien nommé #{@link.name}."
  end

  # POST /links
  def create
    @link = Link.new link_params
    @link.restaurant_id = @restaurant.id

    if @link.save
      flash[:success] = "Votre lien a été crée!"
      redirect_to admin_links_path
    else
      flash[:danger] = "Une erreur est survenue."
      render :new
    end
  end

  # PATCH/PUT /links/1
  def update
    if @link.update(link_params)
      flash[:success] = "Votre lien a été mis à jour!"
      redirect_to admin_links_path
    else
      flash[:danger] = "Une erreur est survenue."
      render :edit
    end
  end

  # DELETE /links/1
  def destroy
    @link.destroy
    flash[:success] = "Votre lien a été supprimé"
    redirect_to admin_links_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:name, :url)
    end

    def check_owner
      redirect_to root_path unless current_user.restaurants.include? @restaurant
    end
end
