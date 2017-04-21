# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  def email_confirmation
    UserMailer.email_confirmation User.new(email: "alex@alex.fr", firstname: "Rousseau", lastname: 'Alexandre')
  end

  def contact
    UserMailer.contact 'object', 'email', 'Lorem ipsum Ut ex ex labore nisi in consequat non officia ea dolore aliquip officia Excepteur aliqua dolor voluptate deserunt pariatur eu tempor aute minim nisi.'
  end

end
