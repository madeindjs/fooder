class SectionsController < ApplicationController
  before_action :set_section, only: [:edit, :update, :destroy]
  before_action :check_login, only: [:new, :create, :edit, :update, :destroy]
  before_action :check_owner, only: [:edit, :update, :destroy]
  before_action :check_admin, only: [:edits]
  before_action :check_restaurant

  layout 'admin', only: [:new]


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


  # POST /sections
  def create
    @section = Section.new(section_params)
    @section.user_id = current_user.id
    @section.restaurant_id = @restaurant.id

    if @section.save
      flash[:success] = "Votre texte d'accueil a été créé."
      redirect_to root_url
    else
      flash[:danger] = "Une erreur est survenue."
      render :new
    end
  end

  # PATCH/PUT /sections/1
  def update
    if @section.update(section_params)
      flash[:success] = "Votre texte d'accueil a été supprimé."
      redirect_to root_url
    else
      flash[:danger] = "Une erreur est survenue."
      render :edit
    end
  end

  # DELETE /sections/1
  def destroy
    @section.destroy
    flash[:success] = "Votre texte d'accueil a été supprimé."
    redirect_to root_url
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
