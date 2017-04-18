# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  def activate_account
    UserMailer.activate_account User.new email: "alex@alex.fr", firstname: "Rousseau", lastname: 'Alexandre'
  end

end
