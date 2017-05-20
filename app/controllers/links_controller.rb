class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  before_action :check_owner, only: [:edit, :update, :destroy]
  before_action :check_admin, only: [:edits]


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

  # GET /links/edits
  # POST /links/edits
  def edits
    @title = "Gérer vos liens"
    @description = "Renommer et réorganisez vos liens."

    @links = @restaurant.links.order :order
    if request.post?
      # to array to save changes to display it to user
      updated_links = []
      fail_updated_links = []
      # loop on all parameters
      params.require(:links).each do |id, data|
        # we get link and verify author is the user
        if link = Link.find(id)
          # update attributes
          link.name  = data['name']
          link.url = data['url']
          link.order = data['order']
          # save only if link changed
          if link.changed?
            # save link and stor in array to display in flash message
            if link.save
              updated_links << link.name
            else
              fail_updated_links << link.name
            end
          end
        end
      end
      # display changes
      flash[:success] = "La mise à jour de #{updated_links} a été effectuée." unless updated_links.empty?
      flash[:danger] = "La mise à jour de #{fail_updated_links} n'a été effectuée."  unless fail_updated_links.empty?
    end
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
      params.require(:link).permit(:name, :url, :link_type_id)
    end

    def check_owner
      redirect_to root_path unless current_user.restaurants.include? @restaurant
    end
end
