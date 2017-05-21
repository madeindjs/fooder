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
        link: links_edit_path
      },
      "Articles" => {
        color: 'warning',
        glypicon: 'comment',
        objects: @restaurant.posts,
        link: links_edit_path
      },
    }
  end
end
