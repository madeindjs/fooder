# Preview all emails at http://localhost:3000/rails/mailers/restaurant_mailer
class RestaurantMailerPreview < ActionMailer::Preview

  def contact
    RestaurantMailer.contact({
                               'object'  => 'Hello',
                               'email'   => 'customer@free.fr',
                               'content' => 'Lorem ipsum Ut ex ex labore nisi in consequat non officia ea dolore aliquip officia Excepteur aliqua dolor voluptate deserunt pariatur eu tempor aute minim nisi.'
    }, 'restaurant@free.fr')
  end

  def commercial
    restaurant = Restaurant.new id: 1, email: 'test@test.fr', name: "Saveurs de Py", slug: 'saveurs-de-py', user_id: 1
    RestaurantMailer.commercial restaurant
  end

end
