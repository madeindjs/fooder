class DishesController < ApplicationController
  before_action :set_dish, only: [:show, :edit, :update, :destroy]
  before_action :check_login, only: [:new, :create, :edit, :edits, :update, :destroy]
  before_action :check_owner, only: [:edit, :update, :destroy]
  before_action :check_restaurant

  # GET /dishes
  # GET /dishes.json
  def index
    @title = "Carte"
    @dishes = @restaurant.dishes
  end

  # GET /dishes/1
  # GET /dishes/1.json
  def show
    @title = @dish.name
  end

  # GET /dishes/new
  def new
    @title = "Nouveau plat"
    @dish = Dish.new
  end

  # GET /dishes/1/edit
  def edit
  end

  # GET /edits
  # POST /edits
  def edits
    redirect_to root_path unless current_user.restaurants.include? @restaurant
    @dishes = @restaurant.dishes
    params.require(:dish).each do |id, data|
      # we get dish and verify author is the user
      if dish = Dish.find(id) and dish.user_id == current_user.id
        dish.name = data['name']
        dish.category_id = data['category']['category_id']
        dish.price = data['price']
        dish.save if dish.changed? 
      end
    end
  end

  # POST /dishes
  # POST /dishes.json
  def create
    @dish = Dish.new(dish_params)
    @dish.user_id = current_user.id
    @dish.restaurant_id = @restaurant.id

    respond_to do |format|
      if @dish.save
        format.html { redirect_to @dish, notice: 'Dish was successfully created.' }
        format.json { render :show, status: :created, location: @dish }
      else
        format.html { render :new }
        format.json { render json: @dish.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dishes/1
  # PATCH/PUT /dishes/1.json
  def update
    respond_to do |format|
      if @dish.update(dish_params)
        format.html { redirect_to @dish, notice: 'Dish was successfully updated.' }
        format.json { render :show, status: :ok, location: @dish }
      else
        format.html { render :edit }
        format.json { render json: @dish.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dishes/1
  # DELETE /dishes/1.json
  def destroy
    @dish.destroy
    respond_to do |format|
      format.html { redirect_to dishes_path, notice: 'Dish was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dish
      @dish = Dish.friendly.find(params[:id])
      redirect_to root_path unless @dish 
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dish_params
      params.require(:dish).permit :name, :description, :category_id, :price, :tags, :picture, 
        :gluten_free, :crustacea_free, :egg_free, :fish_free, :peanut_free, :lactose_free, :nut_free, :sulphite_free
    end

    def check_owner
      redirect_to root_path unless current_user.dishes.include? @dish
    end
end
