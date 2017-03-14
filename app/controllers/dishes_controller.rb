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
    if request.post?
      # to array to save changes to display it to user
      updated_dishes = []
      fail_updated_dishes = []
      # loop on all parameters
      params.require(:dish).each do |id, data|
        # we get dish and verify author is the user
        if dish = Dish.find(id) and dish.user_id == current_user.id
          # update attributes
          dish.name = data['name']
          dish.category_id = data['category']['category_id']
          dish.price = data['price']
          # save only if dish changed
          if dish.changed?
            # save dish and stor in array to display in flash message
            if dish.save
              updated_dishes << dish.name
            else
              fail_updated_dishes << dish.name
            end
          end
        end
      end
      # display changes
      flash[:success] = "La mise à jour de #{updated_dishes} a été effectuée." unless updated_dishes.empty?
      flash[:danger] = "La mise à jour de #{fail_updated_dishes} n'a été effectuée."  unless fail_updated_dishes.empty?
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
        flash[:success] = "Votre plat a l'air délicieux!"
        format.html { redirect_to @dish}
        format.json { render :show, status: :created, location: @dish }
      else
        flash[:danger] = "Une erreur est survenue."
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
        flash[:success] = "Votre plat a été mis à jour avec succès."
        format.html { redirect_to @dish }
        format.json { render :show, status: :ok, location: @dish }
      else
        flash[:danger] = "Une erreur est survenue."
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
      flash[:success] = "Votre plat a été supprimé."
      format.html { redirect_to dishes_path }
      format.json { head :no_content }
    end
  end

  # PATCH /dishes/1/sort/1
  def sort
    @dishes = @restaurant.dishes
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
