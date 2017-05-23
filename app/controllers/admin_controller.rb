class AdminController < ApplicationController
  before_action :check_login
  before_action :check_admin

  layout 'admin'

  # GET /admin
  def index
  end

  # GET /admin/allergens
  def allergens
    @title = "Gestion des allrgènes"
    @description = "Ajoutez rapidement les allrgènes de vos plat."

    @dishes = @restaurant.dishes.order :order
    @categories = @restaurant.categories
  end

  # GET  /admin/dishes
  # POST /admin/dishes
  def dishes
    @title = "Gérer vos produits"
    @description = "Renommer et réorganisez les produits."

    @dishes = @restaurant.dishes.order :order
    @categories = @restaurant.categories
    if request.post?
      # to array to save changes to display it to user
      updated_dishes = []
      fail_updated_dishes = []
      # loop on all parameters
      params.require(:dish).each do |id, data|
        # we get dish and verify author is the user
        if dish = Dish.find(id) and dish.user_id == current_user.id
          # update attributes
          dish.assign_attributes data.permit(:name, :description, :category_id, :price, :tags, :picture, :activate,
            :gluten_free, :crustacea_free, :egg_free, :fish_free, :peanut_free, :lactose_free, :nut_free, :sulphite_free)
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
      flash[:danger] = "La mise à jour de #{fail_updated_dishes} n'a pas été effectuée."  unless fail_updated_dishes.empty?
      redirect_back fallback_location: dishes_edit_path
    end
  end

  # GET  /admin/menus
  # POST /admin/menus
  def menus
    @title = "Gérer les menus"
    @description = "Renommer et réorganisez les menu proposés par ce restaurant."

    @menus = @restaurant.menus.order :order
    if request.post?
      # to array to save changes to display it to user
      updated_menus = []
      fail_updated_menus = []
      # loop on all parameters
      params.require(:menu).each do |id, data|
        # we get menu and verify author is the user
        if menu = Menu.find(id) and menu.user_id == current_user.id
          # update attributes
          menu.name  = data['name']
          menu.price = data['price']
          menu.order = data['order']
          menu.activate = data['activate']
          # save only if menu changed
          if menu.changed?
            # save menu and stor in array to display in flash message
            if menu.save
              updated_menus << menu.name
            else
              fail_updated_menus << menu.name
            end
          end
        end
      end
      # display changes
      flash[:success] = "La mise à jour de #{updated_menus} a été effectuée." unless updated_menus.empty?
      flash[:danger] = "La mise à jour de #{fail_updated_menus} n'a été effectuée."  unless fail_updated_menus.empty?
    end
  end
end
