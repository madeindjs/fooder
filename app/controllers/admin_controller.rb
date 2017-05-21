class AdminController < ApplicationController
  before_action :check_login
  before_action :check_admin

  def index
    @data = {
      "Produits" => {
        color: 'primary',
        glypicon: 'apple',
        objects: @restaurant.dishes.select{ |d| d.activate },
      },
      "Menus" => {
        color: 'danger',
        glypicon: 'cutlery',
        objects: @restaurant.menus.select{ |d| d.activate },
      },
      "Articles" => {
        color: 'warning',
        glypicon: 'comment',
        objects: @restaurant.posts,
      },
    }
  end
end
