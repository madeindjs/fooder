class AdminController < ApplicationController
  before_action :check_login
  before_action :check_admin

  def index
    @data = {
      "Produits" => {
        color: 'primary',
        glypicon: 'apple',
        objects: @restaurant.dishes.select{ |d| d.activate },
        link: links_edit_path
      },
      "Menus" => {
        color: 'danger',
        glypicon: 'cutlery',
        objects: @restaurant.menus.select{ |d| d.activate },
        link: links_edit_path,
        module: 'menus',
      },
      "Articles" => {
        color: 'warning',
        glypicon: 'comment',
        objects: @restaurant.posts,
        link: links_edit_path,
        module: 'blog',
      },
    }.select{|item, data| data[:module] == nil || @restaurant.send("module_"+data[:module])  }
  end
end
