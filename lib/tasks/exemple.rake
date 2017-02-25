require 'rake'

namespace :example do

  desc "Build the complete example"
  task :build => [:environment] do

    # build user
    user = User.exists?(2812) ? User.find(2812) : User.new

    user.id = 2812
    user.email = 'jeanlouis@lagon-bleu.fr'
    user.password = user.password_confirmation = 20462046
    user.firstname = 'Jean-Louis'
    user.lastname = 'Aubert'

    user.save

    # build restaurant
    restaurant = Restaurant.exists?(2812) ? Restaurant.find(2812) : Restaurant.new
    restaurant.id = 2812
    restaurant.user_id = 2812
    restaurant.name = 'Le petit Lagon Bleu'
    restaurant.address = '2 rue des Lilas'
    restaurant.zip_code = '69001'
    restaurant.city = 'Lyon'
    restaurant.module_blog = true

    restaurant.save

  end
  
end

