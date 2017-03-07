class RestaurantsController < ApplicationController
  before_action :check_login, only: [:activate, :new, :create, :edit, :update, :destroy, :opening_hours]
  before_action :set_restaurant, only: [:activate, :show, :edit, :update, :destroy, :opening_hours]
  before_action :check_owner, only: [:edit, :update, :destroy, :opening_hours]

  # GET /restaurants
  # GET /restaurants.json
  def index
    @restaurants = Restaurant.all
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user_id = current_user.id

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully created.' }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    @restaurant.destroy
    respond_to do |format|
      format.html { redirect_to restaurants_url, notice: 'Restaurant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  # POST /restaurants/1/activate_module
  def activate_module
    # get module
    key = "module_#{params['module']}"
    status = @restaurant.send key

    if @restaurant.update({ key => !status })
      redirect_to @restaurant, notice: 'La module à été activé.'
    else
      redirect_to @restaurant, notice: 'Une erreur est survenue.'
    end
  end


  # GET /restaurants/1/contact
  def contact
  end


  # POST /restaurant/1/opening_hours
  def opening_hours
    @opening_hour = OpeningHour.new opening_hour_params
    @opening_hour.user_id = current_user.id
    @opening_hour.restaurant_id = @restaurant.id

    if @opening_hour.save
      redirect_to edit_restaurant_path(@restaurant), notice: 'Restaurant was successfully created.' 
    else
      render :edit
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.friendly.find(params[:id]) unless @restaurant
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      params.require(:restaurant).permit(:name, :address, :zip_code, :city, :module_blog, :picture, :logo, :css)
    end

    def opening_hour_params
      params.require(:opening_hour).permit(:day, :opens, :closes, :valid_from, :valid_through)
    end

    def check_owner
      redirect_to home_path unless current_user.restaurants.include? @restaurant
    end
end
