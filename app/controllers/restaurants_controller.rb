class RestaurantsController < ApplicationController
  before_action :check_login, only: [:activate, :new, :create, :edit, :update, :destroy, :opening_hours]
  before_action :set_restaurant, only: [:activate, :show, :edit, :update, :destroy, :opening_hours]
  before_action :check_owner, only: [:edit, :update, :destroy, :opening_hours]
  before_action :check_restaurant, only: [:contact]

  # GET /restaurants
  def index
    @title = "Nos clients"
    @description = "Liste des restaurants utilisant nos services"

    @restaurants = Restaurant.all
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
    @title = @restaurant.name
    @description = "Un magnifique restaurant"
  end

  # GET /restaurants/new
  def new
    @title = "Nouveau restaurant"
    @description = "Créer un nouveau site pour votre restaurant."
  end

  # GET /restaurants/1/edit
  def edit
    @title = "Editer votre restaurant"
    @description = "Editer les informations relatives à ce restaurant."
  end

  # POST /restaurants
  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user_id = current_user.id

    if @restaurant.save
      flash[:success] = "Votre magnifique restaurant a été créé, commencez à sublimez votre site!"
      redirect_to helpers.restaurant_with_session_key_url(@restaurant)
    else
      flash[:danger] = "Une erreur est survenue."
      render :new
    end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        flash[:success] = "Votre restaurant a été mis à jour."
        format.html { redirect_to @restaurant }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        flash[:danger] = "Une erreur est survenue."
        format.html { render :edit }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    @restaurant.destroy
    flash[:success] = "Votre restaurant a été supprimé :'(."
    respond_to do |format|
      format.html { redirect_to current_user }
      format.json { head :no_content }
    end
  end


  # POST /restaurants/1/activate_module
  def activate_module
    # get module
    key = "module_#{params['module']}"
    status = @restaurant.send key

    if @restaurant.update({ key => !status })
      flash[:success] = "Le module à été activé."
      redirect_to @restaurant
    else
      flash[:danger] = "Une erreur est survenue."
      redirect_to @restaurant
    end
  end


  # GET /restaurants/1/contact
  def contact
    @title = "Contact"
  end

  # GET /allergens
  def allergens
    @title = "Carte des allergènes"
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      begin
        @restaurant = Restaurant.friendly.find(params[:id]) unless @restaurant
      rescue ActiveRecord::RecordNotFound => e
        flash[:danger] = "Ce restaurant n'existe pas, mais vous pouvez le créer."
        redirect_to new_restaurant_url(subdomain: '')
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      params.require(:restaurant).permit :name, :address, :zip_code, :city, :module_blog, :picture, :logo, :css, :logo_display,
          :menus_picture_display, :dishes_picture_display, :posts_picture_display, :sections_picture_display
    end

    def check_owner
      redirect_to root_path unless current_user.restaurants.include? @restaurant
    end
end
