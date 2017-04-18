# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  def email_confirmation
    UserMailer.email_confirmation User.new(email: "alex@alex.fr", firstname: "Rousseau", lastname: 'Alexandre')
  end

end
