class AdminController < ApplicationController
  before_action :check_login
  before_action :check_admin

  def index
    @data = {
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
    }.select{|item, data| data[:module] == nil || @restaurant.send("module_"+data[:module])  }
  end
end
