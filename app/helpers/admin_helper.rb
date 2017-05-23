module AdminHelper

  def sidebar_data
    {
      "Produits" => {
        color: 'primary',
        glyphicon: 'apple',
        objects: @restaurant.dishes.select{ |d| d.activate },
        link: admin_dishes_path
      },
      "Liens" => {
        color: 'danger',
        glyphicon: 'cutlery',
        objects: @restaurant.links,
        link: admin_links_path,
      },
      "Horraires d'ouverture" => {
        color: 'danger',
        glyphicon: 'cutlery',
        objects: @restaurant.opening_hours,
        link: admin_opening_hours_path,
      },
      "Catégories" => {
        color: 'danger',
        glyphicon: 'cutlery',
        objects: @restaurant.links,
        link: admin_categories_path,
      },
      "Menus" => {
        color: 'danger',
        glyphicon: 'cutlery',
        objects: @restaurant.menus.select{ |d| d.activate },
        link: admin_menus_path,
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
