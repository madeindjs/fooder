class DishesController < ApplicationController
  before_action :set_dish, only: [:edit, :update, :destroy]
  before_action :check_login
  before_action :check_owner, only: [:edit, :update, :destroy]
  before_action :check_admin, only: [:edits, :allergens, :import]
  before_action :check_restaurant

  # GET /dishes
  # GET /dishes.json
  # def index
  #   @title = "Carte"
  #   @description = "Carte des produits proposés par ce restaurant."

  #   @dishes = @restaurant.dishes.where(activate: true).order :order
  #   @jsonld = {
  #     "@context":"http://schema.org",
  #     "@type":"ItemList",
  #     "itemListElement": @dishes.map{|dish| dish.to_jsonld}
  #   }
  # end

  # GET /dishes/1
  # GET /dishes/1.json
  # def show
  #   @title = @dish.name
  #   @description = "Un parmi les nombreux déliceux produits proposé par #{@restaurant.name}"

  #   @menus = @dish.menus.uniq
  # end

  # GET /dishes/new
  def new
    render '_form', locals: {dish: Dish.new}, layout:  false
  end

  # GET /dishes/1/edit
  def edit
    render '_form', locals: {dish: @dish}, layout:  false
  end


  # POST /dishes
  # POST /dishes.json
  def create
    @dish = Dish.new(dish_params)
    @dish.user_id = current_user.id
    @dish.restaurant_id = @restaurant.id

    # create category if don't exist
    if params[:category] and params[:category][:name] and not params[:category][:name].empty?
      category = Category.create(name: params[:category][:name], restaurant_id: @restaurant.id)
      @dish.category_id = category.id
    end

    if @dish.save
      render 'dishes/_list', locals: {dishes: @restaurant.dishes_ordered}, layout: false
    else
      render '_form', locals: {dish: @dish}, layout:  false, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /dishes/1
  def update
    if @dish.update(dish_params)
      render 'dishes/_list', locals: {dishes: @restaurant.dishes_ordered}, layout: false
    else
      render '_form', locals: {dish: @dish}, layout:  false, status: :unprocessable_entity
    end
  end

  # DELETE /dishes/1
  def destroy
    @dish.destroy
    render 'dishes/_list', locals: {dishes: @restaurant.dishes_ordered}, layout: false
  end

  # PATCH /dishes/1/sort/1
  def sort
    @dishes = @restaurant.dishes
  end


  # GET  /admin/dishes/import
  # POST /admin/dishes/import
  def import
    if request.post?
      imported_dishes = []
      failed_dishes = []

      params['csv'].each_line do |line|
        data = line.split(';')
        begin
          category = Category.find_or_create data[3], @restaurant.id

          dish = Dish.create(
            user_id: current_user.id, category_id: category.id, restaurant_id: @restaurant.id,
            name: data[0], description: data[1], price: data[2]
          )
          if dish.id
            imported_dishes << dish.name
          else
            failed_dishes << dish.name
          end
        rescue Exception => e
        end
      end
      flash[:success] = "#{imported_dishes} ont été importé." unless imported_dishes.empty?
      flash[:danger] = "La mise à jour de #{failed_dishes} n'ont pas été importé."  unless failed_dishes.empty?
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
    params.require(:dish).permit :name, :description, :category_id, :price, :category_name
      # :tags, :picture, :activate,
      # :gluten_free, :crustacea_free, :egg_free, :fish_free, :peanut_free, :lactose_free, :nut_free, :sulphite_free
  end

  def check_owner
    redirect_to root_path unless current_user.dishes.include? @dish
  end
end
