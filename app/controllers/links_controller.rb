class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  before_action :check_owner, only: [:edit, :update, :destroy]
  before_action :check_admin, only: [:edits]

  layout 'admin', only: [:edit]


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
  # POST /links.json
  def create
    @link = Link.new link_params
    @link.restaurant_id = @restaurant.id

    if @link.save
      flash[:success] = "Votre lien a été crée!"
      redirect_to links_edit_path
    else
      flash[:danger] = "Une erreur est survenue."
      render :new
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    if @link.update(link_params)
      flash[:success] = "Votre lien a été mis à jour!"
      redirect_to links_edit_path
    else
      flash[:danger] = "Une erreur est survenue."
      render :edit
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    redirect_to links_edit_path, notice: 'Link was successfully destroyed.'
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
