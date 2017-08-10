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
          params_sent = data.permit(:name, :description, :category_id, :price, :tags, :picture, :activate,
                                    :gluten_free, :crustacea_free, :egg_free, :fish_free, :peanut_free, :lactose_free, :nut_free, :sulphite_free)
          dish.assign_attributes params_sent
          dish.activate = params_sent.key?(:activate)

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
      redirect_back fallback_location: admin_dishes_path
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

  # GET  /admin/categories
  # POST /admin/categories
  def categories
    @title = "Gérer les categories"
    @description = "Renommer et réorganisez vos catégories."

    @categories = @restaurant.categories.order :order
    if request.post?
      # to array to save changes to display it to user
      updated_categories = []
      fail_updated_categories = []
      # loop on all parameters
      params.require(:categories).each do |id, data|
        # we get category and verify author is the user
        if category = Category.find(id) and category.restaurant_id == @restaurant.id
          # update attributes
          category.name = data['name']
          category.order = data['order']
          # save only if category changed
          if category.changed?
            # save category and stor in array to display in flash message
            if category.save
              updated_categories << category.name
            else
              fail_updated_categories << category.name
            end
          end
        end
      end
      # display changes
      flash[:success] = "La mise à jour de #{updated_categories} a été effectuée." unless updated_categories.empty?
      flash[:danger] = "La mise à jour de #{fail_updated_categories} n'a été effectuée."  unless fail_updated_categories.empty?
    end
  end


  # GET /admin/links
  # POST /admin/links
  def links
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

  # GET  /admin/opening_hours
  # POST /admin/opening_hours
  def opening_hours
    @title = "Horraires d'ouvertures."
    @description = "Gérer les horraires d'ouvertures."

    if request.post?
      # to array to save changes to display it to user
      updated_opening_hours = []
      fail_updated_opening_hours = []
      # loop on all parameters
      params.require(:opening_hour).each do |id, data|

        opening_hour_attributes = {
          restaurant_id: @restaurant.id,
          day:           data['day'],
          opens:         data['opens'],
          closes:        data['closes'],
          valid_from:    data['valid_from'],
          valid_through: data['valid_through'],
        }

        opening_hour = OpeningHour.new

        begin
          opening_hour = OpeningHour.find(id)
        rescue ActiveRecord::RecordNotFound => e
        end

        opening_hour.attributes = opening_hour_attributes



        # save only if opening_hour changed
        if opening_hour.changed? or opening_hour.id = nil
          # save opening_hour and stor in array to display in flash message
          if opening_hour.save
            updated_opening_hours << opening_hour
          else
            fail_updated_opening_hours << opening_hour
          end
        end

      end
      # display changes
      flash[:success] = "La mise à jour des horraires d'ouverture a été effectuée." unless updated_opening_hours.empty?
      flash[:danger] = "Une erreure est survenue."  unless fail_updated_opening_hours.empty?
    end
  end

  # GET  /admin/sections
  # POST /admin/sections
  def sections
    @title = "Gérer le contenu de la page d'accueil."
    @description = "Renommer et réorganisez le contenu proposés par ce restaurant."

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
end
