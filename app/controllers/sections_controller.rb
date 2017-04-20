class SectionsController < ApplicationController
  before_action :set_section, only: [:edit, :update, :destroy]
  before_action :check_login, only: [:new, :create, :edit, :update, :destroy]
  before_action :check_owner, only: [:edit, :update, :destroy]


  # GET /sections/new
  def new
    @title = "Nouveau contenu"
    @description = "Ajouter du contenu à la page d'accueil de ce restaurant."
    @section = Section.new
  end

  # GET /sections/1/edit
  def edit
    @title = "Editer le contenu."
    @description = "Editer le contenu de la page d'accueil."

    render  '_form', locals: {section: @section}, layout:  false if request.xhr?
  end

  # GET  /sections/edit
  # POST /sections/edit
  def edits
    @title = "Gérer le contenu de la page d'accueil."
    @description = "Renommer et réorganisez le contenu proposés par ce restaurant."

    redirect_to root_path unless current_user && current_user.restaurants.include?(@restaurant)
    @sections = @restaurant.sections.order :order
    if request.post?
      # to array to save changes to display it to user
      updated_sections = []
      fail_updated_sections = []
      # loop on all parameters
      params.require(:sections).each do |id, data|
        # we get section and verify author is the user
        if section = Section.find(id) and section.restaurant_id == @restaurant.id
          # update attributes
          section.title = data['title']
          section.order = data['order']
          # save only if section changed
          if section.changed?
            # save section and stor in array to display in flash message
            if section.save
              updated_sections << section.title
            else
              fail_updated_sections << section.title
            end
          end
        end
      end
      # display changes
      flash[:success] = "La mise à jour de #{updated_sections} a été effectuée." unless updated_sections.empty?
      flash[:danger] = "La mise à jour de #{fail_updated_sections} n'a été effectuée."  unless fail_updated_sections.empty?
    end
  end

  # POST /sections
  # POST /sections.json
  def create
    @section = Section.new(section_params)
    @section.user_id = current_user.id
    @section.restaurant_id = @restaurant.id

    respond_to do |format|
      if @section.save
        flash[:success] = "Votre texte d'accueil a été créé."
        format.html { redirect_to root_url }
        format.json { render :show, status: :created, location: @section }
      else
        flash[:danger] = "Une erreur est survenue."
        format.html { render :new }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sections/1
  # PATCH/PUT /sections/1.json
  def update
    respond_to do |format|
      if @section.update(section_params)
        flash[:success] = "Votre texte d'accueil a été supprimé."
        format.html { redirect_to root_url}
        format.json { render :show, status: :ok, location: @section }
      else
        flash[:danger] = "Une erreur est survenue."
        format.html { render :edit }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sections/1
  # DELETE /sections/1.json
  def destroy
    @section.destroy
    flash[:success] = "Votre texte d'accueil a été supprimé."
    respond_to do |format|
      format.html { redirect_to root_url}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section
      @section = Section.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def section_params
      params.require(:section).permit(:title, :content, :picture)
    end

    def check_owner
      redirect_to root_path unless current_user.sections.include? @section
    end
end
