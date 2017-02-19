require 'rake'


namespace :example do

  desc "Build the user example"
  task :user => [:environment] do
    user = User.exists?(2812) ? User.find(2812) : User.new

    user.id = 2812
    user.email = 'jeanlouis@lagon-bleu.fr'
    user.password = user.password_confirmation = 20462046
    user.firstname = 'Jean-Louis'
    user.lastname = 'Aubert'

    user.save
  end

  desc "Build the restaurant example"
  task :restaurant => [:environment, :user ] do
    restaurant = Restaurant.exists?(2812) ? Restaurant.find(2812) : Restaurant.new
    restaurant.id = 2812
    restaurant.user_id = 2812
    restaurant.name = 'Le petit Lagon Bleu'
    restaurant.address = '2 rue des Lilas'
    restaurant.zip_code = '69001'
    restaurant.city = 'Lyon'

    restaurant.save
  end

  desc "Build three sections"
  task :sections => [:environment] do 
    restaurant = Restaurant.find(2812)
    user = User.find(2812)

    restaurant.sections.each{|s| s.destroy}

    Section.create title: "En ferme auberge",
        content: "Découvrez l'authenticité d'un restaurant à la ferme, dégustez les produits du terroir et les spécialités régionales issus des productions de la ferme",
        user_id: user.id,
        restaurant_id: restaurant.id

      Section.create title: "Une table à la ferme ",
        content: "Venez goûter aux multiples saveurs de nos produits fermiers. Chaque menu vous propose des recettes élaborées à partir de produits régionaux de qualité, essentiellement issus de l'exploitation agricole : dégustez vins, charcuterie et viandes, dégustez des fromages … toute la gastronomie régionale à portée de fourchette.",
        user_id: user.id,
        restaurant_id: restaurant.id

      Section.create title: "Un accueil convivial ",
        content: "Reçu par le fermier aubergiste et sa famille, vous apprécierez la convivialité d'un accueil chaleureux dans un cadre architectural authentique et un environnement naturel préservé. N'oubliez pas de réserver votre table avant de vous déplacer ! Et sachez que certains fermiers peuvent aussi vous héberger (en chambres d'hôtes ou gîtes). ",
        user_id: user.id,
        restaurant_id: restaurant.id
  end

  desc "Build dishes example"
  task :dishes => [:environment] do
    restaurant = Restaurant.find(2812)
    user = User.find(2812)

    cat_entree = Category.where(name: 'Entrée', user_id: user.id).first
    cat_plat = Category.where(name: 'Plat', user_id: user.id).first
    cat_dessert = Category.where(name: 'Dessert', user_id: user.id).first

    restaurant.dishes.each{|s| s.destroy}

    { "Saladier Lyonnais" => "harengs, pommes à l'huile, museau de bœuf pied de veau, cocos",
      "Ravioles" => "crème de roquefort et croûtons dorés",
      "Gâteau De Foies De Volaille" => "crème de roquefort et croûtons dorés",
      "Chausson feuilleté" => "béchamel au chèvre chaud, petite salade à l'huile de noix",
    }.each do |name, description|
      Dish.create name: name,
            description: description,
            category_id: cat_entree.id,
            user_id: user.id,
            restaurant_id: restaurant.id
    end

    { "Gras Double Sauté" => "oignons confits, pommes vapeur",
      "Tête Et Langue De Veau" => "ravigote aux herbes",
      "Andouillette Gastronomique" => "'tirée à la ficelle' de chez BRAILLON, sauce moutarde",
      "Bavette D’aloyau De Bœuf" => "pointe d’ail Paillasson de pommes de terre ",
      "La Grosse Quenelle De Brochet" => "(fabrication artisanale) au coulis d'écrevisses, riz",
      "Tablier De Sapeur" => "sauce gribiche, pommes vapeur",
      "Pave De Saumon" => "sauce à l'oseille - pâtes fraîches",
    }.each do |name, description|
      Dish.create name: name,
            description: description,
            category_id: cat_plat.id,
            user_id: user.id,
            restaurant_id: restaurant.id
    end

    { "Fromage Blanc" => "à la crème épaisse",
      "Cervelle De Canut" => "(spécialité Lyonnaise)",
      "Fondant Au Chocolat" => "crème anglaise",
      "Iles Flottantes" => "aux pralines, crème anglaise",
      "Le Guignol" => "Spécialité Chabert : génoise au rhum, appareil à crème brûlée, cassonade, crème Anglaise caramélisée, oranges confites",
    }.each do |name, description|
      Dish.create name: name,
            description: description,
            category_id: cat_dessert.id,
            user_id: user.id,
            restaurant_id: restaurant.id
    end  

  end

  desc "Build the complete example"
  task :all => [:user, :restaurant, :sections, :dishes] do 
  end
  
end

