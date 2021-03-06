module AdminHelper

  def sidebar_data

    dishes = @restaurant.dishes ? @restaurant.dishes.select{ |d| d.activate } : nil
    menus = @restaurant.menus ? @restaurant.menus.select{ |d| d.activate } : nil

    {
      "Produits" => {
        color: 'primary',
        glyphicon: 'apple',
        objects: dishes,
        link: admin_dishes_path,
      },
      "Menus" => {
        color: 'success',
        glyphicon: 'cutlery',
        objects: menus,
        link: admin_menus_path,
        'module': 'menus'
      },
      "Allèrgenes" => {
        color: 'danger',
        glyphicon: 'heart',
        objects: [],
        link: admin_allergens_path,
        'module': 'allergens'
      },
      "Liens" => {
        color: 'primary',
        glyphicon: 'link',
        objects: @restaurant.links,
        link: admin_links_path,
      },
      # "Horraires d'ouverture" => {
      #   color: 'info',
      #   glyphicon: 'time',
      #   link: admin_opening_hours_path,
      # },
      "Catégories" => {
        color: 'warning',
        glyphicon: 'folder-open',
        objects: @restaurant.categories,
        link: admin_categories_path,
      },
      "Articles" => {
        color: 'warning',
        glyphicon: 'comment',
        objects: @restaurant.posts,
        link: posts_path,
        'module': 'blog',
      },
    }.select{|item, data| data[:module] == nil || @restaurant.send("module_"+data[:module])  }
  end

end
