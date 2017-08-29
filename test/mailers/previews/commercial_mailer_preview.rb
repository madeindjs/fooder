# Preview all emails at http://localhost:3000/rails/mailers/commercial_mailer
class CommercialMailerPreview < ActionMailer::Preview

  def presentation
    restaurant = Restaurant.new id: 1, email: 'test@test.fr', name: "Saveurs de Py", slug: 'saveurs-de-py', user_id: 1
    CommercialMailer.presentation restaurant
  end

end
