class RestaurantsController < ApplicationController
  before_action :check_login, only: [:activate, :new, :create, :edit, :update, :destroy, :opening_hours]
  before_action :set_restaurant, only: [:activate, :show, :edit, :update, :destroy, :opening_hours, :send_commercial_mail]
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

    @dishes = @restaurant.dishes_ordered
    @menus = @restaurant.menus_ordered

    @jsonld = @restaurant.to_jsonld

    render layout: 'landing_restaurant'
  end

  # GET /restaurants/new
  def new
    @title = "Nouveau restaurant"
    @description = "Créer un nouveau site pour votre restaurant."
  end

  # GET /restaurants/1/edit
  def edit
    if params['fields']
      fields = params['fields'].split('.')
      render 'shared/_form_field', locals: {model: @restaurant, fields: fields}, layout:  false
    else
      render 'restaurants/_form', locals: {restaurant: @restaurant}, layout:  false
    end
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
    if @restaurant.update(restaurant_params)
      flash[:success] = "Votre restaurant a été mis à jour."
      redirect_to root_url(subdomain: @restaurant.slug)
    else
      flash[:danger] = "Une erreur est survenue."
      render :edit
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
    else
      flash[:danger] = "Une erreur est survenue."
    end
    redirect_back fallback_location: @restaurant
  end


  private


  # Use callbacks to share common setup or constraints between actions.
  def set_restaurant
    begin
      @restaurant = Restaurant.friendly.find(params[:id]) unless @restaurant
    rescue ActiveRecord::RecordNotFound
      flash[:danger] = "Ce restaurant n'existe pas, mais vous pouvez le créer."
      redirect_to new_restaurant_url(subdomain: '')
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def restaurant_params
    data = params.require(:restaurant).permit :name, :address, :zip_code, :city, :picture, :logo, :css, :picture_display, :slug, :plain_opening_hours, :phone, :email
    data.delete :css if data['css'] and data['css'].empty?
    return data
  end

  def check_owner
    render_alert unless current_user.restaurants.include? @restaurant
  end
end
