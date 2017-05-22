class AdminController < ApplicationController
  before_action :check_login
  before_action :check_admin

  before_action :set_sidebar_data

  layout 'admin'

  def index
  end

  def allergens
    @title = "Gestion des allrgènes"
    @description = "Ajoutez rapidement les allrgènes de vos plat."

    @dishes = @restaurant.dishes.order :order
    @categories = @restaurant.categories
  end

  private

  def set_sidebar_data
    @sidebar_data = {
      "Produits" => {
        color: 'primary',
        glyphicon: 'apple',
        objects: @restaurant.dishes.select{ |d| d.activate },
        link: dishes_edit_path
      },
      "Menus" => {
        color: 'danger',
        glyphicon: 'cutlery',
        objects: @restaurant.menus.select{ |d| d.activate },
        link: menus_edit_path,
        module: 'menus',
      },
      "Articles" => {
        color: 'warning',
        glyphicon: 'comment',
        objects: @restaurant.posts,
        link: posts_path,
        module: 'blog',
      },
      "Allèrgenes" => {
          color: 'info',
          glyphicon: 'heart',
          objects: [],
          link: admin_allergens_path,
          module: 'allergens',
      }
    }.select{|item, data| data[:module] == nil || @restaurant.send("module_"+data[:module])  }
  end
end
